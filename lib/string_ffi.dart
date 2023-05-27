import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'ffi.dart';

typedef ProfileConcatC = Pointer<Utf8> Function(Pointer<Utf8> name, Int32 age);
typedef ProfileConcatDart = Pointer<Utf8> Function(Pointer<Utf8> name, int age);

final profileConcat = dynamicLib
    .lookupFunction<ProfileConcatC, ProfileConcatDart>('profile_concat');

String concatStringUsingRust(String fullName, int age) {
  final name = fullName.toNativeUtf8();
  final result = profileConcat(name.cast(), age);
  final profile = result.toDartString();
  // Remember to free the allocated memory
  calloc.free(name);
  calloc.free(result);

  return profile;
}
