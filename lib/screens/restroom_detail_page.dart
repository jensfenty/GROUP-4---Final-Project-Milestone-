import 'package:flutter/material.dart';
import '../models/restroom.dart';

// ─── Restroom Detail Page ─────────────────────────────────────────────────

class RestroomDetailPage extends StatelessWidget {
  final Restroom restroom;
  const RestroomDetailPage({super.key, required this.restroom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          restroom.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
