

import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Utils{



  static showLogs(dynamic data){
    log(data.toString());
  }

  static showMessages(dynamic message){
    Fluttertoast.showToast(msg: message);
  }

}