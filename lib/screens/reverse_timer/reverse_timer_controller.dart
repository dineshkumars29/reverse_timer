import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ReverseTimerController extends GetxController{

  static const methodChannel = MethodChannel('dateHandlerChannel');
  static const eventChannel = EventChannel('timerStreamChannel');
  
  RxString selectedDate = "".obs;
  RxString remainingTime = "".obs;
  // Timer? timer;
  RxBool isLoading = false.obs;
  // RxBool isButtonDisabled = false.obs;

  // Rxn<DateTime> selectedDate = Rxn<DateTime>();
  // Rx<Duration> remainingTime = Duration.zero.obs;

  // DateTime? selectedDate;
  // Duration? remainingTime;

  StreamSubscription? subscription;

  @override
  void onInit() {
    selectDate();
    super.onInit();
  }

    void startTimerStream() {
    subscription?.cancel();
    subscription = eventChannel.receiveBroadcastStream().listen((data) {
      remainingTime.value = data;
      if (data == "Time's up!") {
        subscription?.cancel();
      }
    }, onError: (error) {
      print("Error: $error");
    }, onDone: () {
      isLoading.value = false;
    });
  }
  
    Future<void> selectDate() async {
    try {
      final String result = await methodChannel.invokeMethod('selectDate');
        // timer?.cancel();
        subscription?.cancel();
        remainingTime.value = Duration.zero.toString();
        selectedDate.value = DateTime.parse(result).toString();
        isLoading.value = true;
    } on PlatformException catch (e) {
      print("Failed to select date: '${e.message}'.");
    }
  }

 @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}