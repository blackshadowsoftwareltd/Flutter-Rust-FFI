import 'dart:developer';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              final start = DateTime.now();
              _time();
              log(DateTime.now().difference(start).toString());
            },
            child: const Text('Dart Loop'),
          ),
          const SizedBox(width: double.infinity, height: 10),
          ElevatedButton(
            onPressed: () {
              init();
              final start = DateTime.now();
              printSomething();
              log(DateTime.now().difference(start).toString());
            },
            child: const Text('Rust Loop'),
          ),
        ],
      ),
    );
  }

  _time() {
    int x = 0;
    for (int i = 0; i < 1000000000; i++) {
      x += i;
    }
    log('Sum : $x');
  }
}
