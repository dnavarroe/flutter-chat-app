import 'dart:convert';

import 'package:chat_01/src/domain/global/environment.dart';
import 'package:chat_01/src/domain/models/login_response.dart';
import 'package:chat_01/src/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {

  late User user;
  bool _authenticating = false;
  final _storage = FlutterSecureStorage();

  bool get authenticating => _authenticating;
  set authenticating(bool value){
    _authenticating=value;
    notifyListeners();
  }

  //Getters del token de forma statica
  static Future<String> getToken()async{
    final _storage =  FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    if(token!=null){
      return token;
    }else{
      return '';
    }
  }

  static Future<void> deleteToken()async{
    final _storage =  FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }
  
  Future<bool> login (String email, String password) async{

    authenticating=true;

    final data = {
      "email":email,
      "password":password
    };

    final url = Uri.parse('${Enviroment.apiUrl}/login');

    final res = await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type':'application/json'
    });

    authenticating=false;
    if(res.statusCode == 200){
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.user;

      await _saveToken(loginResponse.token);

      return true;
    }else{
      return false;
    }

    
  }

  Future register (String username, String email, String password) async{

    authenticating=true;

    final data = {
      "username":username,
      "email":email,
      "password":password
    };

    final url = Uri.parse('${Enviroment.apiUrl}/login/new');

    final res = await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type':'application/json'
    });

    authenticating=false;
    if(res.statusCode == 200){
      final registerResponse = loginResponseFromJson(res.body);
      user = registerResponse.user;

      await _saveToken(registerResponse.token);

      return true;
    }else{
      final resp=jsonDecode(res.body);
      return resp['msg'];
    }


  }

  Future<bool> isLoggedIn() async{
    final token = await _storage.read(key: 'token');

    if(token==null){
      return false;
    }

    final url = Uri.parse('${Enviroment.apiUrl}/login/renew');

    final resp = await http.get(url, headers: {
      'Content-Type':'application/json',
      'x-token':token
    });

    if(resp.statusCode == 200){
      final registerResponse = loginResponseFromJson(resp.body);
      user = registerResponse.user;

      await _saveToken(registerResponse.token);

      return true;
    }else{
      this.logout();
      return false;
    }
    
  }

  Future _saveToken(String token) async{
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async{
    return await _storage.delete(key: 'token');
  }

}