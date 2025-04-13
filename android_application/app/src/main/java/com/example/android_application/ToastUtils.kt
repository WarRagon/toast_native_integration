package com.example.android_application

import android.app.Activity
import android.widget.Toast

class ToastUtils(private val activity: Activity) {
    
    fun toast(message: String?) {
        Toast.makeText(activity, message, Toast.LENGTH_SHORT).show()
    }
}