import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reverse_timer/screens/reverse_timer/reverse_timer_controller.dart';

class ReverseTimerScreen extends GetView<ReverseTimerController> {
  ReverseTimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              exit(0);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.grey.shade200,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Reverse Timer',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
        ),
        body: Center(
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                controller.selectedDate.value.isEmpty
                    ? SizedBox(
                      width: 0.7.sw,
                      child: const Text(textAlign: TextAlign.center,
                          "Please pick a future date from the options below",
                          style: TextStyle(color: Colors.red),
                        ),
                    )
                    : Text(
                        "${DateTime.parse(controller.selectedDate.value).day.toString().padLeft(2, '0')}-${DateTime.parse(controller.selectedDate.value).month.toString().padLeft(2, '0')}-${DateTime.parse(controller.selectedDate.value).year.toString()}",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () => controller.selectDate(),
                  child: const Text('Select Future Date'),
                ),
                SizedBox(height: 20.h),
                controller.remainingTime.value.isNotEmpty
                    ? Text(
                        'Time remaining: ${controller.remainingTime.toString().split('.').first}',
                        style: TextStyle(fontSize: 24.sp),
                      )
                      : Container(),
                SizedBox(height: 20.h),
                controller.selectedDate.value.isEmpty
                    ? Container()
                    : ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: controller.isLoading.value
                                ? WidgetStateProperty.all<Color>(Colors.green)
                                : WidgetStateProperty.all<Color>(Colors.black)),
                        onPressed: () => controller.calculateRemainingTime(),
                        child: const Text('Calculate Time Remaining',
                            style: TextStyle(color: Colors.white)),
                      ),
                
                SizedBox(height: 30.h),
              ],
            );
          }),
        ),
      ),
    );
  }
}
