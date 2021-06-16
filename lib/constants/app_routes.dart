import 'package:adlokal/auth/presentation/reset_password_ui.dart';
import 'package:adlokal/auth/presentation/sign_up_ui.dart';
import 'package:adlokal/presentation/ui.dart';
import 'package:get/get.dart';


class AppRoutes {
  AppRoutes._();
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(name: '/', page: () => SplashUI()),
    // GetPage<dynamic>(name: '/signin', page: () => SignInUI()),
    GetPage<dynamic>(name: '/signup', page: () => SignUpUI()),
    GetPage<dynamic>(name: '/home', page: () => HomeUI()),
    GetPage<dynamic>(name: '/settings', page: () => SettingsUI()),
    GetPage<dynamic>(name: '/reset-password', page: () => ResetPasswordUI()),
    // GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
  ];
}
