package com.example.login_app

import android.content.Context
import android.os.Handler
import android.os.Looper
import org.json.JSONObject

class MantraBridge(
    private val context: Context,
    private val onMessageCallback: (String) -> String
) {
    private val mainHandler = Handler(Looper.getMainLooper())

    fun postMessage(jsonString: String, onResponse: (String) -> Unit) {
        Thread {
            val responseJson = try {
                onMessageCallback(jsonString)
            } catch (e: Exception) {
                val errorObj = JSONObject().apply {
                    put("id", "unknown")
                    put("success", false)
                    put("errorCode", "ERR_EXECUTION_FAILED")
                    put("errorMessage", e.message ?: "Unknown native error")
                }
                errorObj.toString()
            }

            mainHandler.post {
                onResponse(responseJson)
            }
        }.start()
    }

    fun dispatchLifecycleEvent(eventName: String, state: String) {
        // Native lifecycle notification
    }
}
