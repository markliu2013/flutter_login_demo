import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Message {
  static success(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }
  static error(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }
}


Future<bool> confirm(
    BuildContext context, {
      Widget? title,
      Widget? content,
      Widget? textOK,
      Widget? textCancel,
    }) async {
  final bool? isConfirm = await showDialog<bool>(
    context: context,
    builder: (_) => WillPopScope(
      child: AlertDialog(
        title: title,
        content: (content != null) ? content : Text('Are you sure continue?'),
        actions: <Widget>[
          TextButton(
            child: textCancel != null ? textCancel : Text('Cancel'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: textOK != null ? textOK : Text('OK'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
      onWillPop: () async {
        Navigator.pop(context, false);
        return true;
      },
    ),
  );

  return (isConfirm != null) ? isConfirm : false;
}