package com.client.uizanidev

import android.os.Bundle
import com.applovin.sdk.AppLovinSdk
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        AppLovinSdk.getInstance(this).initializeSdk()
    }
}
