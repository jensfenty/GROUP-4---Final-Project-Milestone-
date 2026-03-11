import 'package:flutter/material.dart';
import '../models/restroom.dart';

// ─── Rate & Review Page ───────────────────────────────────────────────────

class RateRestroomPage extends StatelessWidget {
  final Restroom restroom;
  const RateRestroomPage({super.key, required this.restroom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Rate & Review',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
