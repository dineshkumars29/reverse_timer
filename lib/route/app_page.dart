import 'package:get/get.dart';
import 'package:reverse_timer/screens/reverse_timer/reverse_timer_bindings.dart';
import 'package:reverse_timer/screens/reverse_timer/reverse_timer_screen.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage(
      name: "/reverseTimerScreen",
      page: () => ReverseTimerScreen(),
      binding: ReverseTimerBindings(),
      preventDuplicates: true,
    ),
  ];
}
