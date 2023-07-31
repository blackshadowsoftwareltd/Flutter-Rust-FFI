import 'dart:ffi' show Double, DynamicLibraryExtension, Void;

import '../ffi.dart' show dynamicLib;

///? loop
typedef PrintSomethingC = Void Function();
typedef PrintSomethingDart = void Function();

final printSomething =
    dynamicLib.lookupFunction<PrintSomethingC, PrintSomethingDart>(
        'print_something'); //? print_something is a function name of rust code.

///? sum
typedef SumTwoNumbersC = Double Function(Double x, Double y);
typedef SumTwoNumbersDart = double Function(double x, double y);

final sumTwoNumbers = dynamicLib
    .lookupFunction<SumTwoNumbersC, SumTwoNumbersDart>('sum_two_numbers');
