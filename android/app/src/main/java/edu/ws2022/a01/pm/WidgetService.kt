package edu.ws2022.a01.pm

import android.app.Service
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Handler
import android.os.IBinder
import android.widget.RemoteViews
import kotlin.random.Random


class WidgetService: Service() {
    override fun onBind(intent: Intent?): IBinder? {
        TODO("Not yet implemented")
        return null
    }
    var handler=Handler()

    override fun onCreate() {
        super.onCreate()

        handler.postDelayed({
                            run()
        },1000)
    }

    private fun run(){
        val appWidgetManager = AppWidgetManager.getInstance(this)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(
            ComponentName(
                this,
                CountDownWidget::class.java
            )
        )

        CountDownWidget().onUpdate(this, appWidgetManager, appWidgetIds)
        handler.postDelayed({ run() },1000)
    }

    override fun onDestroy() {
        super.onDestroy()
        handler.removeCallbacks { run() }
    }

}