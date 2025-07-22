import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'rounded_corners_method_channel.dart';

abstract class RoundedCornersPlatform extends PlatformInterface {
  /// Constructs a RoundedCornersPlatform.
  RoundedCornersPlatform() : super(token: _token);

  static final Object _token = Object();

  static RoundedCornersPlatform _instance = MethodChannelRoundedCorners();

  /// The default instance of [RoundedCornersPlatform] to use.
  ///
  /// Defaults to [MethodChannelRoundedCorners].
  static RoundedCornersPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RoundedCornersPlatform] when
  /// they register themselves.
  static set instance(RoundedCornersPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
