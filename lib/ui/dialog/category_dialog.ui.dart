import 'package:crud_todo_app/viewModel/category.viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryFormDialog extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = useProvider(categoryViewModelProvider);

    final name = useProvider(nameCategoryProvider);
    final emoji = useProvider(emojiCategoryProvider);

    final nameController = useTextEditingController(text: name.state.text);
    final emojiController = useTextEditingController(text: emoji.state.text);

    return ProviderListener<StateController<bool>>(
      provider: isAddedCategoryProvider,
      onChange: (_, addedState) {
        if (addedState.state) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.pop(context),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.close, color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: <Widget>[
                _setTitle(),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    errorText: name.state.message,
                  ),
                  onChanged: (val) =>
                      name.state = categoryProvider.onChangeName(val),
                ),
                TextField(
                  controller: emojiController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Emoji',
                    errorText: emoji.state.message,
                  ),
                  onChanged: (val) =>
                      emoji.state = categoryProvider.onChangeEmoji(val),
                ),
                const SizedBox(height: 30),
                _setButton(categoryProvider, name.state.text, emoji.state.text),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _setTitle() => Text(
        'Add category',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _setButton(CategoryViewModel vm, String name, String emoji) {
    final validation = useProvider(validationCategoryProvider);
    final isAdded = useProvider(isAddedCategoryProvider);

    return RaisedButton(
      color: Color(0xFF4A78FA),
      onPressed: validation.state
          ? () {
              vm.saveCategory(name, emoji);
              isAdded.state = true;
            }
          : null,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'Create',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
