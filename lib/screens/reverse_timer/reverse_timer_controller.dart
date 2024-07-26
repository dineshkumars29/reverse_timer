import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ReverseTimerController extends GetxController{

  static const methodChannel = MethodChannel('dateHandlerChannel');
  
  RxString selectedDate = "".obs;
  RxString remainingTime = "".obs;
  Timer? timer;
  RxBool isLoading = false.obs;
  // RxBool isButtonDisabled = false.obs;

  // Rxn<DateTime> selectedDate = Rxn<DateTime>();
  // Rx<Duration> remainingTime = Duration.zero.obs;

  // DateTime? selectedDate;
  // Duration? remainingTime;

  @override
  void onInit() {
    selectDate();
    super.onInit();
  }
  
    Future<void> selectDate() async {
    try {
      final String result = await methodChannel.invokeMethod('selectDate');
        timer?.cancel();
        remainingTime.value = Duration.zero.toString();
        selectedDate.value = DateTime.parse(result).toString();
        isLoading.value = true;
    } on PlatformException catch (e) {
      print("Failed to select date: '${e.message}'.");
    }
  }

    void calculateRemainingTime() {
    if (selectedDate.value != "") {
        remainingTime.value = DateTime.parse(selectedDate.value).difference(DateTime.now()).toString();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          remainingTime.value = DateTime.parse(selectedDate.value).difference(DateTime.now()).toString();
      });
      isLoading.value = false;
    }
  }
 @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}