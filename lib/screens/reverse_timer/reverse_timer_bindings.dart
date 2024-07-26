import 'package:get/get.dart';
import 'package:reverse_timer/screens/reverse_timer/reverse_timer_controller.dart';

class ReverseTimerBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(ReverseTimerController());
  }
}