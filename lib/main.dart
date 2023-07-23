import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ffi.dart' show initDynamicLib;

import 'src/module/home.dart' show HomeScreen;

void main() {
  initDynamicLib();
  runApp(const ProviderScope(
    child: MaterialApp(
      home: HomeScreen(),
    ),
  ));
}
