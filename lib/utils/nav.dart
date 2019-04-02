
import 'package:flutter/material.dart';

Future<T> push<T>(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

pushReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return widget;
  }));
}

void pop<T extends Object>(BuildContext context, [T result]) {
  Navigator.pop(context, result);
}
