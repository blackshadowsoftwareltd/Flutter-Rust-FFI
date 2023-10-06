import 'dart:developer';
import 'dart:ffi';

import '../ffi.dart';

typedef CrossBeamRust = Void Function();
typedef CrossBeamDart = void Function();

final crossBeamSenderLookup = dynamicLib
    .lookupFunction<CrossBeamRust, CrossBeamDart>('cross_beam_sender');

final crossBeamReceiverLookup = dynamicLib
    .lookupFunction<CrossBeamRust, CrossBeamDart>('cross_beam_receiver');

Future<void> crossBeamSender() async {
  crossBeamSenderLookup();
  log('Sender Invocked');
}

Future<void> crossBeamReceiver() async {
  crossBeamReceiverLookup();
  log('Receiver Invocked');
}
