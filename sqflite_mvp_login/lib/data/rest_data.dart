import 'package:flutter/material.dart';
import 'package:sqflite_mvp_login/utils/newtwork_util.dart';
import 'package:sqflite_mvp_login/model/user_model';

class RestData{
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<User> login(String username, String password){
    return Future.value(new User(username, password));
  }
}