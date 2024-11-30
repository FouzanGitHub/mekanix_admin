import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final VoidCallback? onTap;

  const ProfileAvatar({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 22,
      backgroundImage: AssetImage('assets/images/user2.jpg'),
    );
  }
}
