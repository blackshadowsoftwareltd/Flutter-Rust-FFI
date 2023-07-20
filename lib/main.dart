import 'dart:developer';

import 'package:flutter/material.dart';

import 'ffi.dart' show initDynamicLib, printSomething, sumTwoNumbers;
import 'stream.dart';
import 'string_ffi.dart';

void main() {
  initDynamicLib();
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
              final start = DateTime.now();
              printSomething();
              log(DateTime.now().difference(start).toString());
            },
            child: const Text('Rust Loop'),
          ),
          const SizedBox(width: double.infinity, height: 10),
          ElevatedButton(
            onPressed: () {
              final sum = sumTwoNumbers(10.0, 30.0);
              log('Sum : $sum');
            },
            child: const Text('Calculate Sum'),
          ),
          const SizedBox(width: double.infinity, height: 10),
          ElevatedButton(
            onPressed: () {
              final profile = concatStringUsingRust('Remon Ahammad', 23);
              log('Profile : $profile');
            },
            child: const Text('Profile Concat in Rust code'),
          ),
          const SizedBox(width: double.infinity, height: 10),
          ElevatedButton(
            onPressed: () async {
              await startRustStream();
            },
            child: const Text('Stream'),
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
