package com.example.hueveria_nieto_clientes

import io.flutter.embedding.android.FlutterActivity
import android.os.Build

class MainActivity: FlutterActivity() {
    override fun onFlutterUiDisplayed() {
        if (Build.VERSION.SDK_INT >= 100) { //I gave 100 just to confirm , it shoud be android ver 10
            reportFullyDrawn();
        }
    }
}
