package com.yourdomain.kclogin_flutter

import android.app.Activity
import android.content.Intent
// import androidx.annotation.NonNull
import com.newmedia.kingslogin.CallbackManager
import com.newmedia.kingslogin.KingsLoginCallback
import com.newmedia.kingslogin.KingsLoginException
import com.newmedia.kingslogin.KingsLoginManager
import com.newmedia.kingslogin.helper.KingsLogin
import com.newmedia.kingslogin.model.KcScopes
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

/** KcloginFlutterPlugin */
class KcloginFlutterPlugin :
    FlutterPlugin,
    MethodChannel.MethodCallHandler, 
    ActivityAware,
    PluginRegistry.ActivityResultListener {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private lateinit var callbackManager: CallbackManager

    private val CHANNEL = "com.yourdomain/kclogin_flutter"

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler(this)
        callbackManager = CallbackManager.Factory.create()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) { // ✅ Fixed
        when (call.method) {
            "init" -> {
                activity?.let {
                    KingsLogin.init(it.applicationContext)
                    result.success(null)
                } ?: result.error("NO_ACTIVITY", "Activity not attached", null)
            }

            "login" -> {
                val scopes = call.argument<List<String>>("scopes") ?: emptyList()

                if (activity == null) {
                    result.error("NO_ACTIVITY", "Activity not available", null)
                    return
                }

                val manager = KingsLoginManager.getInstance()

                manager.registerCallback(
                    callbackManager,
                    object : KingsLoginCallback {

                        override fun onSuccess(code: String, scopes: KcScopes) {
                            KingsLoginManager.getInstance()
                                .unregisterCallback(callbackManager)

                            result.success(
                                mapOf(
                                    "status" to "success",
                                    "authorization_code" to code,
                                    "scopes" to mapOf(
                                        "accepted" to scopes.accepted,
                                        "declined" to scopes.declined
                                    )
                                )
                            )
                        }

                        override fun onCancel() {
                            KingsLoginManager.getInstance()
                                .unregisterCallback(callbackManager)
                            result.success(mapOf("status" to "cancel"))
                        }

                        override fun onError(error: KingsLoginException) {
                            KingsLoginManager.getInstance()
                                .unregisterCallback(callbackManager)
                            result.error("KINGS_ERROR", error.message, null)
                        }
                    }
                )

                KingsLogin.requestPermissions(activity!!, scopes)
            }

            else -> result.notImplemented()
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        return callbackManager.onActivityResult(requestCode, resultCode, data)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
