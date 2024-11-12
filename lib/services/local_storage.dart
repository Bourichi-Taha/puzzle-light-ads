import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _tokenKey = 'token';

  // set token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // remove toke
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  //set language
  static Future<void> savelanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  //get language
  static Future<String?> getlanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

  //set darkmode
  static Future<void> savedarkmode(bool darkmode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkmode', darkmode);
  }

  //get darkmode
  static Future<bool?> getdarkmode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('darkmode');
  }

  //set subdomain
  static Future<void> savesubdomain(String subdomain) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('subdomain', subdomain);
  }

  //get subdomain
  static Future<String?> getsubdomain() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('subdomain');
  }

  //remove subdomain
  static Future<void> removesubdomain() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('subdomain');
  }

  //set isfirt time
  static Future<void> saveisfirsttime(bool isfirsttime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isfirsttime', isfirsttime);
  }

  //get isfirst time
  static Future<bool?> getisfirsttime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isfirsttime');
  }

  //save score
  static Future<void> savescore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', score);
  }

  //get score
  static Future<int?> getscore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('score');
  }

  //save mission done
  static Future<void> savemissiondone(List<String> mission) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('missiondone', mission);
  }

  //get mission done
  static Future<List<String>?> getmissiondone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('missiondone');
  }

}
