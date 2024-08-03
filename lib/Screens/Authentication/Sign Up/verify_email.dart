import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_pos/GlobalComponents/button_global.dart';
import 'package:mobile_pos/Screens/Authentication/Sign%20Up/repo/sign_up_repo.dart';
import 'package:mobile_pos/constant.dart';
import 'package:pinput/pinput.dart' as p;

import '../forgot password/repo/forgot_pass_repo.dart';
import '../forgot password/set_new_password.dart';
import '../profile_setup_screen.dart';


class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key,  required this.email, required this.isFormForgotPass}) : super(key: key);
  final String email;
  final bool isFormForgotPass;


  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  ///__________variables_____________
  bool isClicked = false;

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final _pinputKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  static const focusedBorderColor = kMainColor;
  static const fillColor = Color(0xFFF3F3F3);
  final defaultPinTheme = p.PinTheme(
    width: 45,
    height: 52,
    textStyle: const TextStyle(
      fontSize: 20,
      color: kTitleColor,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kBorderColor),
    ),
  );

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kWhite,
        surfaceTintColor: kWhite,
        centerTitle: true,
        titleSpacing: 16,
        title: Text(
          'Verity Email',
          style: textTheme.titleMedium?.copyWith(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Verification',
              style: textTheme.titleMedium?.copyWith(fontSize: 24.0),
            ),
            const SizedBox(height: 8.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(text: '6-digits pin has been sent to your email address: ', style: textTheme.bodyMedium?.copyWith(color: kGreyTextColor,fontSize: 16), children: [
                TextSpan(
                  text: widget.email,
                  style: textTheme.bodyMedium?.copyWith(color: kTitleColor, fontWeight: FontWeight.bold,fontSize: 16),
                )
              ]),
            ),
            const SizedBox(height: 24.0),
            Form(
              key: _pinputKey,
              child: p.Pinput(
                length: 6,
                controller: pinController,
                focusNode: focusNode,
                // listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 11),
                validator: (value) {
                  if ((value?.length ?? 0) < 6) {
                    return 'Enter valid OTP';
                  } else {
                    return null;
                  }
                },
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: kMainColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kTitleColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            UpdateButton(
              onpressed: widget.isFormForgotPass
                  ? () async {
                      if (isClicked) {
                        return;
                      }
                      focusNode.unfocus();
                      if (_pinputKey.currentState?.validate() ?? false) {
                        isClicked = true;
                        EasyLoading.show();
                        ForgotPassRepo repo = ForgotPassRepo();
                        if (await repo.verifyOTPForgotPass(email: widget.email, otp: pinController.text, context: context)) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SetNewPassword(
                                email: widget.email,
                              ),
                            ),
                          );
                        } else {
                          isClicked = false;
                        }
                      }
                    }
                  : () async {
                      if (isClicked) {
                        return;
                      }
                      focusNode.unfocus();
                      if (_pinputKey.currentState?.validate() ?? false) {
                        isClicked = true;
                        EasyLoading.show();
                        SignUpRepo repo = SignUpRepo();
                        if (await repo.verifyOTP(email: widget.email, otp: pinController.text, context: context)) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  ProfileSetup(),
                            ),
                          );
                        } else {
                          isClicked = false;
                        }
                      }
                    },
              text: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}
