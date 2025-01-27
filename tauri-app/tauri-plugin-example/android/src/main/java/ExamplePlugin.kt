package com.plugin.example

import android.app.Activity
import android.widget.Toast
import app.tauri.annotation.Command
import app.tauri.annotation.InvokeArg
import app.tauri.annotation.TauriPlugin
import app.tauri.plugin.Invoke
import app.tauri.plugin.JSObject
import app.tauri.plugin.Plugin

@InvokeArg
class PingArgs {
  var value: String? = null
}

@InvokeArg
class ToastArgs {
  var value: String? = null
}

@TauriPlugin
class ExamplePlugin(private val activity: Activity) : Plugin(activity) {
  private val implementation = Example()

  @Command
  fun ping(invoke: Invoke) {
    val args = invoke.parseArgs(PingArgs::class.java)

    val ret = JSObject()
    ret.put("value", implementation.pong(args.value ?: "default value :("))
    invoke.resolve(ret)
  }

  @Command
  fun toast(invoke: Invoke) {
    val args = invoke.parseArgs(PingArgs::class.java)

    Toast.makeText(activity, args.value, Toast.LENGTH_SHORT).show()
  }
}
