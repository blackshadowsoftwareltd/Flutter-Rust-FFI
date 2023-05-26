import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX

late DynamicLibrary dynamicLib;

void initDynamicLib() {
  dynamicLib = Platform.isLinux
      ? DynamicLibrary.open(

          ///? open dynamic library for linux using .so file path
          '/home/remon/Flutter/Flutter-Rust-FFI/rust/target/release/librust.so')
      : DynamicLibrary.process();
}

typedef PrintSomethingC = Void Function();
typedef PrintSomethingDart = void Function();

final printSomething =
    dynamicLib.lookupFunction<PrintSomethingC, PrintSomethingDart>(
        'print_something'); //? print_something is a function name of rust code.

typedef SumTwoNumbersC = Double Function(Double x, Double y);
typedef SumTwoNumbersDart = double Function(double x, double y);

final sumTwoNumbers = dynamicLib
    .lookupFunction<SumTwoNumbersC, SumTwoNumbersDart>('sum_two_numbers');
