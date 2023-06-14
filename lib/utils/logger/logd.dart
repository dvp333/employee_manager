import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

// dart:developer.log does not seem to have the maximum length limit like
// print() or debugPrint(). It's useful when printing long things like Firebase
// tokens
void logd(String message) {
  if (kReleaseMode) return;

  developer.log(
    '${DateTime.now()} - $message',
    name: 'my_books',
    time: DateTime.now(),
  );
}
