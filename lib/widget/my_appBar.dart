import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      elevation: 5.0,
      centerTitle: true,
      backgroundColor: Colors.cyan[900],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
