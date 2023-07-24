

package com.example.platform_part

import android.content.Context
import android.view.View
import android.widget.ImageButton
import android.graphics.drawable.Drawable
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

class ButtonPlatformView(
    context: Context,
    id: Int,
    creationParams: String,
    flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
) : PlatformView {
    private var button = ImageButton(context).apply {
                setOnClickListener {
                    Log.i("button pressed", "icon button was pressed");
                    var appId = creationParams;
                    Log.i("app id", appId);
                    var launchIntent = manager.getLaunchIntentForPackage(appID);
                    if (launchIntent != null) { 
                        context.startActivity(launchIntent);//null pointer check in case package name was not found
                    }
                }
            }
    private var manager = context.getPackageManager();
    private var imageLoaded = false;
    private var appID = creationParams

    override fun getView(): View {
        Log.i("platform", "request view")
        if (!imageLoaded) {
            var image: Drawable = manager.getApplicationIcon(appID);
            button.setImageDrawable(image)
            imageLoaded = true;
            Log.i("platform", "icone created")
        }

        return button!!
    }

    override fun dispose() {
        Log.i("appIcon", "view destroyed")
    }

    


}