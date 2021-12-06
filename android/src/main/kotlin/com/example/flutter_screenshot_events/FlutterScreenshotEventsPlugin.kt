package com.example.flutter_screenshot_events

import android.app.Activity
import android.content.Context
import android.view.WindowManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterScreenshotsPlugin */
class FlutterScreenshotEventsPlugin : FlutterPlugin, MethodCallHandler, ActivityAware{

  private lateinit var channel: MethodChannel
  private lateinit var activity: Activity;
  var disableScreenshots: Boolean = false

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_screenshots")
    channel.setMethodCallHandler(this)
  }

  private fun setDisableScreenshotsStatus(disable: Boolean) {
    if (disable) {
      activity.window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE);
    } else {
      activity.window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "disableScreenshots") {
      var disable = call.argument<Boolean>("disable") == true
      setDisableScreenshotsStatus(disable)
      result.success("")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    setDisableScreenshotsStatus(this.disableScreenshots)
  }

  override fun onDetachedFromActivity() {
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    setDisableScreenshotsStatus(this.disableScreenshots)
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

}

