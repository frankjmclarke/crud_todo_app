import 'package:crud_todo_app/dependency/dependency.dart';
import 'package:crud_todo_app/navigator/crud_todo_information_parser.dart';
import 'package:crud_todo_app/navigator/crud_todo_router_delegate.dart';
import 'package:crud_todo_app/repository/category_repository.dart';
import 'package:crud_todo_app/repository/todo_repository.dart';
import 'package:crud_todo_app/ui/category_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../test_utils/mocks.dart';

void main() {
  group('App Navigator 2 Test', () {
    late MockFirestore mockFirestoreInstance;

    late MockCategoryService mockCategoryService;
    late ICategoryRepository categoryRepository;

    late MockTodoService mockTodoService;
    late ITodoRepository todoRepository;

    late CrudTodoRouterDelegate todoRouterDelegate;
    late CrudTodoInformationParser todoInfoParser;

    setUpAll(() {
      mockFirestoreInstance = MockFirestore();

      mockCategoryService = MockCategoryService();
      categoryRepository = CategoryRepository(mockCategoryService);

      mockTodoService = MockTodoService();
      todoRepository = TodoRepository(mockTodoService);

      registerFallbackValue(MyTodoFake());
      registerFallbackValue(MyCategoryFake());

      // Using simple Riverpod to test dependencies
      final container = ProviderContainer();

      todoRouterDelegate = container.read(crudTodoRouterDelegateProvider);
      todoInfoParser = container.read(crudTodoInformationParserProvider);
    });

    Future<void> pumpMainScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            firebasePod.overrideWithValue(mockFirestoreInstance),
            categoryServicePod.overrideWithValue(mockCategoryService),
            todoServicePod.overrideWithValue(mockTodoService),
            categoryRepositoryPod.overrideWithValue(categoryRepository),
            todoRepositoryPod.overrideWithValue(todoRepository),
          ],
          child: MaterialApp.router(
            routerDelegate: todoRouterDelegate,
            routeInformationParser: todoInfoParser,
            backButtonDispatcher: RootBackButtonDispatcher(),
          ),
        ),
      );
    }

    testWidgets(
      'Show $CategoryListView screen',
      (tester) async {
        await pumpMainScreen(tester);

        expect(find.byType(CategoryListView), findsOneWidget);

        expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
        expect(find.text('Lists'), findsOneWidget);
        expect(find.byType(FloatingActionButton), findsOneWidget);
      },
      variant: TargetPlatformVariant.all(),
    );
  });
}
