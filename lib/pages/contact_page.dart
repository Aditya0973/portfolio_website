import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text(
          'Contact Me',
          style: TextStyle(fontSize: 48, color: Colors.white),
        ),
      ),
    );
  }
}