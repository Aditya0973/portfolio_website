import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  Navbar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavItem('Home', 0),
          _buildNavItem('Projects', 1),
          _buildNavItem('Contact', 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () => onTap(index),
        child: Text(
          title,
          style: TextStyle(
            color: currentIndex == index ? Colors.tealAccent : Colors.white,
            fontSize: 18,
            fontWeight: currentIndex == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}