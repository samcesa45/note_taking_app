import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback onSettingsTap;

  const Header(this.title, this.onSettingsTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Avenir',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: onSettingsTap,
          icon: Icon(Icons.more_vert, color: Theme.of(context).iconTheme.color),
        ),
      ],
    );
  }
}
