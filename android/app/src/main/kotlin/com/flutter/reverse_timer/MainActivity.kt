package com.flutter.reverse_timer

//import android.widget.Toast
import android.graphics.Color
import android.annotation.SuppressLint
import android.app.DatePickerDialog
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.*

class MainActivity : FlutterActivity() {
    private val methodChannel = "dateHandlerChannel"
    private var lastSelectedDate: Long? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannel).setMethodCallHandler { call, result ->
            if (call.method == "selectDate") {
                showDatePicker(result)
            }
        }
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

//        Toast.makeText(this, "Please select a future date", Toast.LENGTH_LONG).show()

        val datePickerDialog = DatePickerDialog(
            this,
            { _, year, month, dayOfMonth ->
                calendar.set(year, month, dayOfMonth)
                val dateFormat = SimpleDateFormat("yyyy-MM-dd")
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

            datePickerDialog.getButton(DatePickerDialog.BUTTON_POSITIVE)?.setTextColor(Color.GRAY)
            datePickerDialog.getButton(DatePickerDialog.BUTTON_NEGATIVE)?.setTextColor(Color.RED)

    }
    }
