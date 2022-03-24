import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyBwrqkeJsZ70NpqmHyGsbAj9Oq3_-hJHiI';

  bool isLoading = false;
  Future<String> crearUser(String email, String pass) async {
    final Map<String, dynamic> authData = {'email': email, 'password': pass};

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedREsp = json.decode(resp.body);

    //print(decodedREsp);
    print(decodedREsp);
    if (decodedREsp.containsKey('idToken')) {
      return '';
    } else {
      return decodedREsp['error']['message'];
    }
  }

  Future<String> inicioSesion(String email, String pass) async {
    isLoading = true;
    notifyListeners();
    final Map<String, dynamic> datosInicio = {'email': email, 'password': pass};

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(datosInicio));
    final Map<String, dynamic> decodedREsp = json.decode(resp.body);

    print(decodedREsp);

    if (decodedREsp['error'] != null) {
      //printreturn decodedREsp['idToken'];
      isLoading = false;
      notifyListeners();
      return decodedREsp['error']['message'];
    } else {
      return '';
    }
  }
}
