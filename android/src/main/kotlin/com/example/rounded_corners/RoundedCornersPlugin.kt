package com.example.rounded_corners

import android.os.Build
import android.view.RoundedCorner
import android.view.View
import android.view.WindowInsets
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class RoundedCornersPlugin : FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler {
  private lateinit var channel: MethodChannel
  private var activityBinding: ActivityPluginBinding? = null

  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "rounded_corners_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activityBinding = binding
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activityBinding = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activityBinding = binding
  }

  override fun onDetachedFromActivity() {
    activityBinding = null
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method == "getRoundedCorners") {
      val activity = activityBinding?.activity
      if (activity == null) {
        result.error("NO_ACTIVITY", "Plugin chưa attach vào Activity", null)
        return
      }

      // Chỉ hỗ trợ Android 12+ (API 31)
      if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
        result.success(null)
        return
      }

      val decorView: View = activity.window.decorView
      // Lấy WindowInsets nền tảng
      val windowInsets: WindowInsets? = decorView.rootWindowInsets
      if (windowInsets == null) {
        result.success(null)
        return
      }

      // Extension để chuyển RoundedCorner? -> Map
      fun RoundedCorner?.toMap(): Map<String, Any>? {
        this ?: return null
        return mapOf(
          "radius" to radius.toDouble(),
          "x" to center.x.toDouble(),
          "y" to center.y.toDouble()
        )
      }

      // Lấy thông tin từng góc
      val topLeft    = windowInsets.getRoundedCorner(RoundedCorner.POSITION_TOP_LEFT).toMap()
      val topRight   = windowInsets.getRoundedCorner(RoundedCorner.POSITION_TOP_RIGHT).toMap()
      val bottomLeft = windowInsets.getRoundedCorner(RoundedCorner.POSITION_BOTTOM_LEFT).toMap()
      val bottomRight= windowInsets.getRoundedCorner(RoundedCorner.POSITION_BOTTOM_RIGHT).toMap()

      // Ép kiểu rõ ràng để Kotlin không bị “infer type V” nữa
      val cornersMap: Map<String, Any?> = mapOf(
        "topLeft" to topLeft,
        "topRight" to topRight,
        "bottomLeft" to bottomLeft,
        "bottomRight" to bottomRight
      )

      result.success(cornersMap)
    } else {
      result.notImplemented()
    }
  }
}
