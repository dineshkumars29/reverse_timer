// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:reverse_timer/screens/reverse_timer/reverse_timer_controller.dart';

// class ReverseTimerScreen extends GetView<ReverseTimerController> {
//   ReverseTimerScreen({Key? key}) : super(key: key);
// // final ReverseTimerController controller = Get.put(ReverseTimerController());
//   @override
//   Widget build(BuildContext context) {
//     // final controller = Get.find<ReverseTimerController>();
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 exit(0);
//               },
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: Colors.black,
//               )),
//           backgroundColor: Colors.grey.shade200,
//           elevation: 0.0,
//           centerTitle: true,
//           title: Text(
//             'Reverse Timer',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w700,
//               fontSize: 18.sp,
//             ),
//           ),
//         ),
//         body: Center(child: Obx(() {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               controller.isLoading.value == true
//                   ? Container(
//                       color: Colors.green,
//                       height: 20.sp,
//                       width: 20.sp,
//                     )
//                   : Container(
//                       color: Colors.red,
//                       height: 20.sp,
//                       width: 20.sp,
//                     ),
//               // Text("${selectedDate}"),
//               controller.selectedDate.value == ""
//                   ? const Text(
//                       "pick Future date below",
//                       style: TextStyle(color: Colors.red),
//                     )
//                   : Text(
//                       "${DateTime.parse(controller.selectedDate.value).day.toString().padLeft(2, '0')}-${DateTime.parse(controller.selectedDate.value).month.toString().padLeft(2, '0')}-${DateTime.parse(controller.selectedDate.value).year.toString()}"),
//               ElevatedButton(
//                 onPressed: () => controller.selectDate(),
//                 child: const Text('Select Future Date'),
//               ),
//               controller.selectedDate.value == ""
//                   ? Container()
//                   : ElevatedButton(
//                       onPressed: () => controller.calculateRemainingTime(),
//                       child: const Text('Calculate Time Remaining'),
//                     ),
//               const SizedBox(height: 20),
//               controller.remainingTime.value != ""
//                   ? Text(
//                       'Time remaining: ${controller.remainingTime.toString().split('.').first}',
//                       style: const TextStyle(fontSize: 24),
//                     )
//                   : const Text(
//                       'Select a date and click calculate.',
//                       style: TextStyle(fontSize: 14),
//                     ),
//               const SizedBox(height: 30),
//             ],
//           );
//         })),
//       ),
//     );
//   }
// }

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
                // Container(
                //   color: controller.isLoading.value ? Colors.green : Colors.red,
                //   height: 20.sp,
                //   width: 20.sp,
                // ),
                SizedBox(height: 20.h),
                controller.selectedDate.value.isEmpty
                    ? const Text(
                        "Pick a future date below",
                        style: TextStyle(color: Colors.red),
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
                SizedBox(height: 20.h),
                controller.remainingTime.value.isNotEmpty
                    ? Text(
                        'Time remaining: ${controller.remainingTime.toString().split('.').first}',
                        style: TextStyle(fontSize: 24.sp),
                      )
                    : const Text(
                        'Select a date and click calculate.',
                        style: TextStyle(fontSize: 14),
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
