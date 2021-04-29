import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  String get dateTimeToFormattedString =>
      DateFormat("MMM d, ''yy - HH:mm").format(this);

  String get timeDateToFormattedString =>
      DateFormat('HH:mm - MMMM d').format(this);

  String get timeFormattedString => DateFormat('HH:mm').format(this);

  bool get isDurationNegative => difference(DateTime.now()).isNegative;

  bool get isToday => difference(DateTime.now()).inDays == 0;
}

extension IntUtils on int {
  DateTime get millisecondsToDate => DateTime.fromMillisecondsSinceEpoch(this);
}

extension StringUtils on String {
  bool get verifyEmoji {
    for (final s in EmojiParser().unemojify(this).split(' ')) {
      return s.startsWith(':') || s.endsWith(':');
    }

    return false;
  }
}

extension WidgetUtils on Widget {
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget paddingSymmetric({double h = 0.0, double v = 0.0}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
        child: this,
      );

  Widget paddingOnly({double l = 0, double t = 0, double r = 0, double b = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: l, top: t, bottom: b, right: r),
      child: this,
    );
  }
}
