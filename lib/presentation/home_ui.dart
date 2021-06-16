import 'package:adlokal/presentation/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import 'components/form_vertical_spacing.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (AuthController controller) => !controller.isWithDataUser
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('home.title'.tr),
                actions: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Get.to(SettingsUI());
                      }),
                ],
              ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 120),
                    // Avatar(controller.firestoreUser.value!),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FormVerticalSpace(),

                        // Text(
                        //     'home.uidLabel'.tr +
                        //         ': ' +
                        //         controller.firestoreUser.value!.uid,
                        //     style: TextStyle(fontSize: 16)),
                        // FormVerticalSpace(),
                        // Text(
                        //     'home.nameLabel'.tr +
                        //         ': ' +
                        //         controller.firestoreUser.value!.name,
                        //     style: TextStyle(fontSize: 16)),
                        // FormVerticalSpace(),
                        // Text(
                        //     'home.emailLabel'.tr +
                        //         ': ' +
                        //         controller.firestoreUser.value!.email,
                        //     style: TextStyle(fontSize: 16)),
                        // FormVerticalSpace(),
                        // Text(
                        //     'home.adminUserLabel'.tr +
                        //         ': ' +
                        //         controller.admin.value.toString(),
                        //     style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
