import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class ProfileScreenHolder extends StatelessWidget {
  const ProfileScreenHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        title: const Text('User Profile '),
      ),
      actions: [
        SignedOutAction((context) {
          Navigator.of(context).pop();
        })
      ],
      children: [
        Text('hey'),
      ],
    );
  }
}
