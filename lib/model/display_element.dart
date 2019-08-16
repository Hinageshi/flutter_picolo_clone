import 'package:flutter/material.dart';

class DisplayElement {
  final MaterialColor _backgroundColor;
  final String _title;
  final String _content;

  DisplayElement(MaterialColor backgroundColor, String title, String content)
      : _backgroundColor = backgroundColor,
        _title = title,
        _content = content;

  MaterialColor get backgroundColor => _backgroundColor;
  String get title => _title;
  String get content => _content;
}
