import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SnackBarService {
  late BuildContext _buildContext;
  static SnackBarService instance = SnackBarService();

  SnackBarService() {}

  set buildContext(BuildContext _context) {
    _buildContext = _context;
  }

  void showSnackBarError(String _message) {
    ScaffoldMessenger.of(_buildContext).showSnackBar(
      SnackBar(
        content: Text(
          _message,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showSnackBarSuccess(String _message) {
    ScaffoldMessenger.of(_buildContext).showSnackBar(
      SnackBar(
        content: Text(
          _message,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
