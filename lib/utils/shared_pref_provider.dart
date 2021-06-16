import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProvider {

  SharedPrefProvider._();

  SharedPreferences _sharedPreferences;

  static final SharedPrefProvider sharedPref = SharedPrefProvider._();

  Future<SharedPreferences> get sharedPreferences async {
    if (_sharedPreferences != null)
      return _sharedPreferences;

    else
      return _sharedPreferences = await initSharedPref();
  }

  initSharedPref() async {
    var sharedPref = await SharedPreferences.getInstance();
    return sharedPref;
  }

  Future<String> get deviceId async {
    final sharedPref = await sharedPreferences;
    return sharedPref.getString("deviceId");
  }

  Future<String> get firebaseToken async {
    final sharedPref = await sharedPreferences;
    return sharedPref.getString("deviceToken");
  }

  Future<bool> get isRegistered async{
    final sharedPref = await sharedPreferences;
    return sharedPref.getBool("isRegistered") ?? false;
  }

  Future<bool> get notifEnabled async{
    final sharedPref = await sharedPreferences;
    return sharedPref.getBool("notifEnabled") ?? false;
  }

  Future<String> get states async{
    final sharedPref = await sharedPreferences;
    return sharedPref.getString("states");
  }

  Future<String> get lastLocation async{
    final sharedPref = await sharedPreferences;
    return sharedPref.getString("lastLocation");
  }

  setStates(String states) async{
  final sharedPref = await sharedPreferences;
  sharedPref.setString("states",states);
  }

  setLastLocation(String lastLocation) async{
    final sharedPref = await sharedPreferences;
    sharedPref.setString("lastLocation",lastLocation);

  }

  setNotifEnabled(bool notifEnabled) async{
    final sharedPref = await sharedPreferences;
    sharedPref.setBool("notifEnabled", notifEnabled);
  }

  setDeviceId(String id) async{
    final sharedPref = await sharedPreferences;
    sharedPref.setString("deviceId", id);
  }

  setFirebaseToken(String token) async {
    final sharedPref = await sharedPreferences;
    return sharedPref.setString("deviceToken", token);
  }

  setIsRegistered(bool val) async{
    final sharedPref = await sharedPreferences;
    return sharedPref.setBool("isRegistered", val);
  }
}

