import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider extends ChangeNotifier {
  late GoogleSignInAccount user;

  void setUser(GoogleSignInAccount user) {
    this.user = user;
    notifyListeners();
  }
}
