import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../controllers/controllers.dart';
import '../models/models.dart';
import 'components/components.dart';
import 'components/segmented_selector.dart';

class SettingsUI extends StatelessWidget {
  //final LanguageController languageController = LanguageController.to;
  //final ThemeController themeController = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return ListView(
      children: <Widget>[
        languageListTile(context),
        themeListTile(context),
        ListTile(
            title: Text('settings.updateProfile'.tr),
            trailing: ElevatedButton(
              onPressed: () async {
                // Get.to(UpdateProfileUI());
              },
              child: Text(
                'settings.updateProfile'.tr,
              ),
            )),
        ListTile(
          title: Text('settings.signOut'.tr),
          trailing: ElevatedButton(
            onPressed: () {
              AuthController.to.signOut();
            },
            child: Text(
              'settings.signOut'.tr,
            ),
          ),
        )
      ],
    );
  }

  GetBuilder<LanguageController> languageListTile(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (LanguageController controller) => ListTile(
        title: Text('settings.language'.tr),
        trailing: DropdownPicker(
          menuOptions: Globals.languageOptions,
          selectedOption: controller.currentLanguage,
          onChanged: (String? value) async {
            await controller.updateLanguage(value!);
            Get.forceAppUpdate();
          },
        ),
      ),
    );
  }

  GetBuilder<ThemeController> themeListTile(BuildContext context) {
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: 'system', value: 'settings.system'.tr, icon: Icons.brightness_4),
      MenuOptionsModel(
          key: 'light', value: 'settings.light'.tr, icon: Icons.brightness_low),
      MenuOptionsModel(
          key: 'dark', value: 'settings.dark'.tr, icon: Icons.brightness_3)
    ];
    return GetBuilder<ThemeController>(
      builder: (ThemeController controller) => ListTile(
        title: Text('settings.theme'.tr),
        trailing: SegmentedSelector(
          selectedOption: controller.currentTheme,
          menuOptions: themeOptions,
          onValueChanged: (value) {
            controller.setThemeMode(value);
          },
        ),
      ),
    );
  }
}
