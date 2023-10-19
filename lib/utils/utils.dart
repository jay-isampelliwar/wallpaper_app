import 'package:flutter/material.dart';

class Utils {
  static showErrorSnackBar(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }
}
