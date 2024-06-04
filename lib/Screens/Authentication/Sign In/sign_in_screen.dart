import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant.dart';
import '../Sign Up/sign_up_screen.dart';
import '../forgot password/forgot_password.dart';
import 'Repo/sign_in_repo.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showPassword = true;
  bool _isChecked = false;

  ///__________variables_____________
  bool isClicked = false;

  final key = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserCredentials();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void _loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isChecked = prefs.getBool('remember_me') ?? false;
      if (_isChecked) {
        emailController.text = prefs.getString('email') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  void _saveUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('remember_me', _isChecked);
    if (_isChecked) {
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
    } else {
      prefs.remove('email');
      prefs.remove('password');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kMainColor,
        titleSpacing: 16,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 16.0),
        //   child: Back(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        title: Text(
          'Sign in',
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
                  'Welcome back!',
                  style: textTheme.titleMedium?.copyWith(fontSize: 30.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Please enter your details.',
                  style: textTheme.bodyMedium?.copyWith(color: kGreyTextColor),
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Email',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: 'email',
                    hintText: 'Enter email address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email can\'t be empty';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Password',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: passwordController,
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
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      checkColor: Colors.white,
                      activeColor: kMainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      fillColor: MaterialStateProperty.all(_isChecked ? kMainColor : Colors.transparent),
                      visualDensity: const VisualDensity(horizontal: -4),
                      side: const BorderSide(color: kBackgroundColor),
                      value: _isChecked,
                      onChanged: (newValue) {
                        setState(() {
                          _isChecked = newValue!;
                        });
                      },
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Remember me',
                      style: textTheme.bodyMedium?.copyWith(color: kGreyTextColor),
                    ),
                    const Spacer(),
                    TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  const ForgotPassword(),
                        ),
                      ),
                      child: Text(
                        'Forgot password?',
                        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                PrimaryButton(
                  onPressed: () async {
                    if (isClicked) {
                      return;
                    }
                    if (key.currentState?.validate() ?? false) {
                      isClicked = true;
                      EasyLoading.show();
                      LogInRepo repo = LogInRepo();
                      if (await repo.logIn(email: emailController.text, password: passwordController.text, context: context)) {
                        _saveUserCredentials();
                        EasyLoading.showSuccess('Done');
                      } else {
                        isClicked = false;
                      }
                    }
                  },
                  text: 'Login',
                )
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SignUpScreen();
                },));
              },
              hoverColor: kMainColor.withOpacity(0.1),
              child: RichText(
                text: TextSpan(
                  text: 'Don’t have an account? ',
                  style: textTheme.bodyMedium?.copyWith(color: kGreyTextColor),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
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
