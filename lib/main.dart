import 'package:flutter/material.dart';

import 'ffi.dart' show init, printSomething;

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          init();
          printSomething();
        },
        child: const Text('FFI'),
      )),
    );
  }
}
