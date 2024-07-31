package com.flutter.reverse_timer

import android.annotation.SuppressLint
import android.app.DatePickerDialog
import android.graphics.Color
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.*

class MainActivity : FlutterActivity() {
    private val METHOD_CHANNEL = "dateHandlerChannel"
    private val EVENT_CHANNEL = "timerStreamChannel"
    private var lastSelectedDate: Long? = null
    private var events: EventChannel.EventSink? = null
    private var timer: Timer? = null
    private val mainHandler = Handler(Looper.getMainLooper())

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "selectDate") {
                    showDatePicker(result)
                }
            }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    this@MainActivity.events = events
                    startTimer()
                }

                override fun onCancel(arguments: Any?) {
                    timer?.cancel()
                }
            })
    }

    @SuppressLint("SimpleDateFormat")
    private fun showDatePicker(result: MethodChannel.Result) {
        val calendar = Calendar.getInstance()
        val today = Calendar.getInstance()

        if (lastSelectedDate != null && lastSelectedDate!! > System.currentTimeMillis()) {
            calendar.timeInMillis = lastSelectedDate!!
        } else {
            calendar.add(Calendar.DAY_OF_YEAR, 1)
        }

        today.add(Calendar.DAY_OF_YEAR, 1)

        val datePickerDialog = DatePickerDialog(
            this,
            { _, year, month, dayOfMonth ->
                calendar.set(year, month, dayOfMonth, 0, 0, 0)
                val dateFormat = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")
                val selectedDate = dateFormat.format(calendar.time)
                lastSelectedDate = calendar.timeInMillis
                result.success(selectedDate)
            },
            calendar.get(Calendar.YEAR),
            calendar.get(Calendar.MONTH),
            calendar.get(Calendar.DAY_OF_MONTH)
        )
        datePickerDialog.datePicker.minDate = today.timeInMillis
        datePickerDialog.show()

        datePickerDialog.getButton(DatePickerDialog.BUTTON_POSITIVE).setTextColor(Color.GRAY)
        datePickerDialog.getButton(DatePickerDialog.BUTTON_NEGATIVE).setTextColor(Color.RED)
    }

    private fun startTimer() {
        timer?.cancel()
        timer = Timer()
        timer?.scheduleAtFixedRate(object : TimerTask() {
            override fun run() {
                lastSelectedDate?.let {
                    val difference = it - System.currentTimeMillis()
                    if (difference <= 0) {
                        mainHandler.post {
                            events?.success("Time's up!")
                        }
                        timer?.cancel()
                    } else {
                        val seconds = (difference / 1000) % 60
                        val minutes = (difference / (1000 * 60)) % 60
                        val hours = (difference / (1000 * 60 * 60)) % 24
                        val days = difference / (1000 * 60 * 60 * 24)
                        val totalHours = days * 24 + hours
                        val timeRemaining = String.format("%02d:%02d:%02d", totalHours, minutes, seconds)
                        mainHandler.post {
                            events?.success(timeRemaining)
                        }
                    }
                }
            }
        }, 0, 1000)
    }

}
