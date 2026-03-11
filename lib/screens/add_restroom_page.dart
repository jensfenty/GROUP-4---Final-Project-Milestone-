import 'package:flutter/material.dart';

// ─── Add New Restroom Page ────────────────────────────────────────────────

class AddRestroomPage extends StatelessWidget {
  const AddRestroomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add New Restroom',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
