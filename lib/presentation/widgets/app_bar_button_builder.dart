import 'package:flutter/material.dart';

class AppBarButtonBuilder extends StatelessWidget {
  const AppBarButtonBuilder({
    super.key, required this.icon, required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.grey.shade200,
        child:  Icon(icon, color: Colors.grey,),
      ),
    );
  }
}