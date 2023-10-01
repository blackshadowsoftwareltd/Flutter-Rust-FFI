import 'dart:ffi' show DynamicLibraryExtension, Int32, Pointer, Uint8;

import 'package:ffi/ffi.dart';

import '../ffi.dart' show dynamicLib;

typedef NotificationRust = Pointer<Utf8> Function(
    Pointer<Uint8> title, Pointer<Uint8> message);
typedef NotificationDart = Pointer<Utf8> Function(
    Pointer<Uint8> title, Pointer<Uint8> message);

final showNativeNotification = dynamicLib
    .lookupFunction<NotificationRust, NotificationDart>('show_notification');

Future<void> showNotification(String title, String message) async {
  final titlePtr = title.toNativeUtf8();
  final messagePtr = message.toNativeUtf8();
  showNativeNotification(titlePtr.cast(), messagePtr.cast());

  calloc.free(titlePtr);
  calloc.free(messagePtr);
}

typedef PersistentNotificationRust = Pointer<Utf8> Function(
    Pointer<Uint8> appName,
    Pointer<Uint8> title,
    Pointer<Uint8> message,
    Int32 timeout);
typedef PersistentNotificationDart = Pointer<Utf8> Function(
    Pointer<Uint8> appName,
    Pointer<Uint8> title,
    Pointer<Uint8> message,
    int timeout);

final showNativePersistentNotification = dynamicLib.lookupFunction<
    PersistentNotificationRust,
    PersistentNotificationDart>('show_persistent_notification');

Future<void> showPersistentNotification(
    String appName, String title, String message, Duration duration) async {
  final appNamePtr = appName.toNativeUtf8();
  final titlePtr = title.toNativeUtf8();
  final messagePtr = message.toNativeUtf8();
  showNativePersistentNotification(appNamePtr.cast(), titlePtr.cast(),
      messagePtr.cast(), duration.inMilliseconds);

  calloc.free(appNamePtr);
  calloc.free(titlePtr);
  calloc.free(messagePtr);
}
