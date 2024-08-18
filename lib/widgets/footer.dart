// widgets/footer.dart
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        '© 2024 Aditya Kumar. All rights reserved.',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}