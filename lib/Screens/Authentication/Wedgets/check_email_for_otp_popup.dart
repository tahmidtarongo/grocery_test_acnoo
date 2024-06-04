import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../constant.dart';

Future<dynamic> checkEmailForCodePupUp({required String email, required BuildContext context, required TextTheme textTheme}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext contextPopUp) {
      return WillPopScope(
        onWillPop: () async => false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 38.0, 20.0, 28.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Verify Your Email',
                    style: textTheme.titleMedium?.copyWith(fontSize: 24.0),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'We have sent a confirmation email to',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal, color: kGreyTextColor),
                  ),
                  Text(
                    email,
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'It May be that the mail ended up in your spam folder.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal, color: kGreyTextColor),
                  ),
                  const SizedBox(height: 17.0),
                  PrimaryButton(
                    onPressed: () {
                      Navigator.pop(contextPopUp, true);
                    },
                    text: 'Got It !',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
