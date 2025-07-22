import 'package:flutter_test/flutter_test.dart';
import 'package:rounded_corners/rounded_corners.dart';

void main() {
  test('getRoundedCorners trên non-Android trả null', () async {
    final r = await RoundedCorners.getRoundedCorners();
    expect(r, isNull);
  });
}