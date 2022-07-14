import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:github_search_users/Constants/const_keys.dart';
import 'package:github_search_users/Models/user_model.dart';
import 'package:http/http.dart' as http;

class ServicesApi extends ChangeNotifier {
  Auser? _auser;
  Auser? get getAuser =>_auser;
  Future getUser(String username) async {
    final httpsUri = Uri(
      scheme: 'https',
      host: 'api.github.com',
      path: 'users/$username',
    );
    try {
      final getResponse = await http
          .get(httpsUri, headers: {'Authentication': 'token $tokenApi'});
          _auser = Auser.fromJson(jsonDecode(getResponse.body));
          print("here is the result");
    } catch (e) {
      _auser = null;
      print("here in the catch");
    }
  }
}
