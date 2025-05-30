import 'package:fluter_rust_message_app/src/rust/lib.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  void login(User user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  Future<void> reloadUserById(String userId, String filePath) async {
    final updatedUser = await getUserById(filePath: filePath, userId: userId);
    if (updatedUser != null) {
      _user = updatedUser;
      notifyListeners();
    }
  }
}
