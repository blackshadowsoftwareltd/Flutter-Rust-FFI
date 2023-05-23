import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX

typedef PrintSomethingC = Void Function();
typedef PrintSomethingDart = void Function();

late DynamicLibrary dynamicLib;

void init() {
  dynamicLib = Platform.isLinux
      ? DynamicLibrary.open(

          ///? open dynamic library for linux using .so file path
          '/home/remon/Flutter/f_test/rust/target/release/libr_test.so')
      : DynamicLibrary.process();
}

final printSomething =
    dynamicLib.lookupFunction<PrintSomethingC, PrintSomethingDart>(
        'print_something');//? print_something is a function name of rust code.
