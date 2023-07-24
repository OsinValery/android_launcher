package com.example.platform_part

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory




class AppIconViewFactory(private val flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE){

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return ButtonPlatformView(context!!, viewId, args as String, flutterPluginBinding)
    }


    companion object {
        const val TYPE = "icon_view";
    }
}



