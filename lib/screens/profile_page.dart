import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person_outline, size: 64, color: Colors.blueGrey),
          SizedBox(height: 16),
          Text(
            'Profile',
            style: TextStyle(fontSize: 18, color: Colors.blueGrey),
          ),
          SizedBox(height: 8),
          Text('Coming soon', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
