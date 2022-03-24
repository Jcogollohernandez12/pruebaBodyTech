import 'package:flutter/material.dart';

class LoginFromProvider extends ChangeNotifier {
  GlobalKey<FormState> claveForm = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String password2 = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

//metodo para validar la contraseña y email
  bool isValidForm() {
    print(claveForm.currentState?.validate() ?? false);
    return claveForm.currentState?.validate() ?? false;
  }
}
