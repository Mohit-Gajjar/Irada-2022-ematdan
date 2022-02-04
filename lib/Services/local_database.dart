import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  static String sharedPrefsOrganiserLoggedin = "ORGANISERLOGGEDIN";
  static String sharedPrefsVoterLoggedIn = "VOTERLOGGEDIN";

  static Future<bool> saveOrganiserLoggedInState(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPrefsOrganiserLoggedin, isLoggedIn);
  }

  static Future<bool> saveVoterLoggedInState(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPrefsVoterLoggedIn, isLoggedIn);
  }

  static Future<bool?> getOrganiserSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPrefsOrganiserLoggedin);
  }

  static Future<bool?> getVoterSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPrefsVoterLoggedIn);
  }
}
