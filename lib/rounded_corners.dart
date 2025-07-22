import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class RoundedCorners {
  static const MethodChannel _channel =
  MethodChannel('rounded_corners_flutter');

  /// Lấy thông tin 4 góc bo, hoặc null nếu không hỗ trợ
  static Future<ScreenRoundedCorners?> getRoundedCorners() async {
    if (defaultTargetPlatform != TargetPlatform.android) return null;
    final res = await _channel.invokeMapMethod<dynamic, dynamic>(
        'getRoundedCorners');
    if (res == null) return null;
    return ScreenRoundedCorners._fromMap(res);
  }
}

class RoundedCornerInfo {
  final double radius;
  final Offset center;

  const RoundedCornerInfo({
    required this.radius,
    required this.center,
  });

  factory RoundedCornerInfo._fromMap(Map<dynamic, dynamic> m) {
    return RoundedCornerInfo(
      radius: (m['radius'] as num).toDouble(),
      center: Offset(
        (m['x'] as num).toDouble(),
        (m['y'] as num).toDouble(),
      ),
    );
  }
}

class ScreenRoundedCorners {
  final RoundedCornerInfo? topLeft;
  final RoundedCornerInfo? topRight;
  final RoundedCornerInfo? bottomLeft;
  final RoundedCornerInfo? bottomRight;

  const ScreenRoundedCorners({
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
  });

  factory ScreenRoundedCorners._fromMap(Map<dynamic, dynamic> m) {
    RoundedCornerInfo? parse(String key) {
      final map = m[key] as Map<dynamic, dynamic>?;
      return map == null ? null : RoundedCornerInfo._fromMap(map);
    }
    return ScreenRoundedCorners(
      topLeft: parse('topLeft'),
      topRight: parse('topRight'),
      bottomLeft: parse('bottomLeft'),
      bottomRight: parse('bottomRight'),
    );
  }
}