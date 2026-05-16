import 'package:get/get.dart';

import '../modules/authentication/bindings/auth_binding.dart';
import '../modules/authentication/views/login_view.dart';
import '../modules/home/views/home_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
    ),
  ];
}
