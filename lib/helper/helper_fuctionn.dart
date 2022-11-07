import 'package:shared_preferences/shared_preferences.dart';

class HelperFuction {
  static String userLoginKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKAY";
  static String userEmailKey = "USEREMAILKEY";
  static Future<bool> saveUserLoggedInStatus(bool isUerLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoginKey, isUerLoggedIn);
  }

  static Future<bool> saveUserName(String isUerName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, isUerName);
  }

  static Future<bool> saveUserEmail(String isUerEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, isUerEmail);
  }

  static Future<bool?> getUserLogedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    return sf.getBool(userLoginKey);
  }

  static Future<String?> getUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(userNameKey);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(userEmailKey);
  }
}
