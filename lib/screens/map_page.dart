import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.map_outlined, size: 64, color: Colors.blueGrey),
          SizedBox(height: 16),
          Text(
            'Restroom Map',
            style: TextStyle(fontSize: 18, color: Colors.blueGrey),
          ),
          SizedBox(height: 8),
          Text('Coming soon', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
