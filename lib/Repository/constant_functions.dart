import 'package:shared_preferences/shared_preferences.dart';

Future<String> getAuthToken() async {
  final prefs = await SharedPreferences.getInstance();

  print("Bearer ${prefs.getString('token') ?? ''}");
  return"Bearer ${prefs.getString('token') ?? ''}";
}

Future<void> saveUserData({required Map<String, dynamic> userData}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userId', userData['user_id']);
  await prefs.setString('tokenType', userData['token_type']);
  await prefs.setString('token', userData['token']);
}
