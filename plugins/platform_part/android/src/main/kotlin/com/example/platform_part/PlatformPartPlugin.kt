package com.example.platform_part

import androidx.annotation.NonNull
import android.content.Context
import android.content.pm.ApplicationInfo
import android.util.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


fun getAppsList(context: Context) :ArrayList<Map<String, String>> {
  val packageManager = context.getPackageManager()
  var result = ArrayList<Map<String, String>>()
  // get list of all the apps installed 
  var appinfo = packageManager.getInstalledPackages(0)    
  
  for(i in  appinfo.indices){
    var info = appinfo[i]
    var condition = (info.applicationInfo.flags and ApplicationInfo.FLAG_SYSTEM) != ApplicationInfo.FLAG_SYSTEM
    if (true) {
      val appName = info.applicationInfo.loadLabel(packageManager).toString()
      
      var app = mapOf<String, String>(
          "name" to appName,
          "id" to info.packageName
      )

      result.add(app)
    }
      
  }

  return result
}


class PlatformPartPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "platform_part")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.getApplicationContext()

    flutterPluginBinding.platformViewRegistry.registerViewFactory(
      AppIconViewFactory.TYPE,
      AppIconViewFactory(flutterPluginBinding),
    )
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "apps_list") {
      val info = getAppsList(context)
      Log.i("platform", "list found")
      result.success(info)
    }
    else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
