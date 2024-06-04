import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_pos/Screens/Authentication/forgot%20password/repo/forgot_pass_repo.dart';

import '../../../constant.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({Key? key,  required this.email}) : super(key: key);

  final String email;

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final _formKey = GlobalKey<FormState>();
  bool isClicked = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool showPassword = true;
  bool showConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
          'Change Password',
          style: textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change password',
                  style: textTheme.titleMedium?.copyWith(fontSize: 30.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Replace the password with a new one for more security',
                  style: textTheme.bodyMedium?.copyWith(color: kGreyTextColor),
                ),
                const SizedBox(height: 24.0),
                Text(
                  'New Password',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: showPassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
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
                Text(
                  'Confirm Password',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: showConfirmPassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Re-type password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showConfirmPassword = !showConfirmPassword;
                        });
                      },
                      icon: Icon(
                        showConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: kGreyTextColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password can\'t be empty';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                PrimaryButton(
                  onPressed: () async {
                    if (isClicked) {
                      return;
                    }
                    if (_formKey.currentState?.validate() ?? false) {
                      isClicked = true;
                      EasyLoading.show();
                      ForgotPassRepo repo = ForgotPassRepo();
                      if (await repo.resetPass(email: widget.email, password: _confirmPasswordController.text, context: context)) {
                        Navigator.pop(context);
                      } else {
                        isClicked = false;
                      }
                    }
                  },
                  text: 'Save',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
