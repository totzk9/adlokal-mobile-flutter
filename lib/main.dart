import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import './constants/constants.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_analytics/observer.dart';
import './controllers/controllers.dart';
import './helpers/helpers.dart';
import 'presentation/components/loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
      builder: (LanguageController languageController) => Loading(
        child: GetMaterialApp(
          translations: Localization(),
          locale: languageController.getLocale,
          navigatorObservers: [
            // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ],
          debugShowCheckedModeBanner: false,
          //defaultTransition: Transition.fade,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: '/',
          getPages: AppRoutes.routes,
        ),
      ),
    );
  }
}
