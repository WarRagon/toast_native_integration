package com.example.android_application

import android.os.Bundle

import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent

import androidx.compose.foundation.layout.Column
import androidx.compose.material3.Button
import androidx.compose.material3.Text

class MainActivity : ComponentActivity() {
    private lateinit var ToastUtils: ToastUtils

    override fun onCreate(state: Bundle?) {
        super.onCreate(state)

        ToastUtils = ToastUtils(this)

        setContent {
            Column {
                Button(
                    onClick = { ToastUtils.toast("toast") },
                    content = { Text("Toast") }
                )
            }
        }
    }
}
