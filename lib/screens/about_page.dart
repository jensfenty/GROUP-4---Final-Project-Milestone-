import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info_outline, size: 64, color: Colors.blueGrey),
          SizedBox(height: 16),
          Text(
            'About PottyPal',
            style: TextStyle(fontSize: 18, color: Colors.blueGrey),
          ),
          SizedBox(height: 8),
          Text('Coming soon', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
