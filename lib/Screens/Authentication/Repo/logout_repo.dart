import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Const/api_config.dart';
import 'package:http/http.dart' as http;

import '../../../Repository/constant_functions.dart';
import '../../SplashScreen/splash_screen.dart';

class LogOutRepo {
  Future<void> _signOut({required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("userId");
    await prefs.remove("tokenType");
    await prefs.remove("token");
    EasyLoading.showSuccess('Successfully Logged Out');
    const SplashScreen().launch(context, isNewTask: true);
  }

  Future<void> signOutApi({required BuildContext context}) async {
    final uri = Uri.parse('${APIConfig.url}/sign-out');

    final response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Authorization': await getAuthToken(),
    });

    if (response.statusCode == 200) {
      await _signOut(context: context);
      // Parse into Party objects
    } else {
      EasyLoading.showError('Logout Failed');
    }
  }
}
