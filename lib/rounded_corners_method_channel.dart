import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'rounded_corners_platform_interface.dart';

/// An implementation of [RoundedCornersPlatform] that uses method channels.
class MethodChannelRoundedCorners extends RoundedCornersPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('rounded_corners');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
