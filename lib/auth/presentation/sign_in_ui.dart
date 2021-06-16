import 'dart:core';

import 'package:adlokal/ui/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/controllers.dart';
import '../../helpers/helpers.dart';
import '../../ui/auth/auth.dart';
import '../../ui/components/components.dart';

class SignInUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LogoGraphicHeader(),
                  const SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: 'auth.emailFormField'.tr,
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (String value) {},
                    onSaved: (String? value) =>
                        authController.emailController.text = value!,
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.passwordController,
                    iconPrefix: Icons.lock,
                    labelText: 'auth.passwordFormField'.tr,
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (String value) {},
                    onSaved: (String? value) =>
                        authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      labelText: 'auth.signInButton'.tr,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // authController.signInWithEmailAndPassword(context);
                          Get.to(HomeUI());
                        }
                      }),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: 'auth.resetPasswordLabelButton'.tr,
                    onPressed: () => Get.to(ResetPasswordUI()),
                  ),
                  LabelButton(
                    labelText: 'auth.signUpLabelButton'.tr,
                    onPressed: () => Get.to(SignUpUI()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
