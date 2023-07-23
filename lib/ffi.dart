import 'dart:ffi' show DynamicLibrary; // For FFI
import 'dart:io' show Platform; // For Platform.isX

late DynamicLibrary dynamicLib;

void initDynamicLib() {
  dynamicLib = Platform.isLinux
      ? DynamicLibrary.open(
          // '/home/remon/Flutter/Flutter-Rust-FFI/rust/target/x86_64-unknown-linux-gnu/release/librust.so'

          ///? open dynamic library for linux using .so file path
          '/home/remon/Flutter/Flutter-Rust-FFI/rust/target/release/librust.so',
        )
      : DynamicLibrary.process();
}
