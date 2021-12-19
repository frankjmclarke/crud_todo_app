import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class FormFactor {
  static double desktop = 900;
  static double tablet = 600;
  static double handset = 300;
}

enum ScreenType { desktop, tablet, handset, watch }

ScreenType getFormFactor(BuildContext context) {
  final deviceWidth = MediaQuery.of(context).size.shortestSide;

  if (deviceWidth > FormFactor.desktop) return ScreenType.desktop;
  if (deviceWidth > FormFactor.tablet) return ScreenType.tablet;
  if (deviceWidth > FormFactor.handset) return ScreenType.handset;

  return ScreenType.watch;
}

enum DeviceSegment { mobile, desktop, mobileWeb, desktopWeb, other }

DeviceSegment getDevice() {
  final isAndroid = Platform.isAndroid;
  final isIOS = Platform.isIOS;

  final isMobile = isAndroid || isIOS;
  final isDesktop = Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  if (!kIsWeb && isMobile) return DeviceSegment.mobile;
  if (!kIsWeb && isDesktop) return DeviceSegment.desktop;

  if (kIsWeb || isMobile) return DeviceSegment.mobileWeb;
  if (kIsWeb || isDesktop) return DeviceSegment.desktopWeb;

  return DeviceSegment.other;
}

bool isPortrait(BuildContext context) =>
    MediaQuery.of(context).orientation == Orientation.portrait;