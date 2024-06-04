import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_pos/Screens/Authentication/Sign%20Up/repo/sign_up_repo.dart';
import 'package:mobile_pos/Screens/Authentication/Sign%20Up/verify_email.dart';
import '../../../constant.dart';
import '../Sign In/sign_in_screen.dart';
import '../Wedgets/check_email_for_otp_popup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ///__________Variables________________________________
  bool showPassword = true;
  bool isClicked = false;

  ///________Key_______________________________________
  GlobalKey<FormState> key = GlobalKey<FormState>();

  ///___________Controllers______________________________
  TextEditingController nameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  ///________Dispose____________________________________
  @override
  void dispose() {
    super.dispose();
    nameTextController.dispose();
    passwordTextController.dispose();
    emailTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Back(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'Sign Up',
          style: textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create an Account',
                  style: textTheme.titleMedium?.copyWith(fontSize: 30.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Please enter your details.',
                  style: textTheme.bodyMedium?.copyWith(color: kGreyTextColor),
                ),
                const SizedBox(height: 24.0),

                ///____________Name______________________________________________
                Text(
                  'Full Name',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: nameTextController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your full name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'name can\'n be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

                ///__________Email______________________________________________
                Text(
                  'Email',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: 'email',
                    hintText: 'Enter email address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email can\'n be empty';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

                ///___________Password_____________________________________________
                Text(
                  'Password',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: passwordTextController,
                  keyboardType: TextInputType.text,
                  obscureText: showPassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    // labelText: 'Password',
                    hintText: 'Enter password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(
                        showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: kGreyTextColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password can\'t be empty';
                    } else if (value.length < 6) {
                      return 'Please enter a bigger password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),

                ///________Button___________________________________________________
                PrimaryButton(
                  onPressed: () async {
                    if (isClicked) {
                      return;
                    }
                    if (key.currentState?.validate() ?? false) {
                      isClicked = true;
                      EasyLoading.show();
                      SignUpRepo repo = SignUpRepo();
                      if (await repo.signUp(name: nameTextController.text, email: emailTextController.text, password: passwordTextController.text, context: context)) {
                        if (await checkEmailForCodePupUp(email: emailTextController.text, context: context, textTheme: textTheme)) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyEmail(
                                email: emailTextController.text,
                                isFormForgotPass: false,
                              ),
                            ),
                          );
                        }
                      } else {
                        isClicked = false;
                      }
                    }
                  },
                  text: 'Sign Up',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              highlightColor: kMainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(3.0),
              onTap: () => Navigator.pop(context),
              hoverColor: kMainColor.withOpacity(0.1),
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: textTheme.bodyMedium?.copyWith(color: kGreyTextColor),
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: textTheme.bodyMedium?.copyWith(color: kMainColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
