package edu.ws2022.a01.pm

import android.app.AlarmManager
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Context.ALARM_SERVICE
import android.content.Intent
import android.os.Build
import android.widget.RemoteViews
import android.widget.Toast
import androidx.annotation.RequiresApi
import java.time.LocalDateTime
import java.time.ZoneOffset
import java.time.temporal.ChronoField
import java.util.*
import kotlin.random.Random


/**
 * Implementation of App Widget functionality.
 */
class CountDownWidget : AppWidgetProvider() {
    var ACTION_AUTO_UPDATE_WIDGET = "android.appwidget.action.ACTION_AUTO_UPDATE_WIDGET"
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
        super.onEnabled(context)
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        super.onReceive(context, intent)
    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    val views = RemoteViews(context.packageName, R.layout.count_down_widget)
    var endTime=Calendar.getInstance()
    endTime.set(2024,8,15,23,59,59)
    var mi=((endTime.timeInMillis-Calendar.getInstance().timeInMillis)/1000)
    views.setTextViewText(R.id.daysText, (mi/3600/24).toString())
    views.setTextViewText(R.id.hoursTxt, ((mi/3600)-((mi/3600/24)*24)).toString())
    val alarmManager =context.getSystemService(ALARM_SERVICE) as AlarmManager
    val intent = Intent(context, WidgetService::class.java)
    val pendingIntent = PendingIntent.getService(context, 0, intent, 0)

    alarmManager!!.setRepeating(
        AlarmManager.RTC_WAKEUP,
        System.currentTimeMillis() + 1000,
        1000,
        pendingIntent
    )
    appWidgetManager.updateAppWidget(appWidgetId, views)
}