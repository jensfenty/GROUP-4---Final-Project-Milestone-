import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class Restroom {
  final Color imageColor;
  final String imagePath;
  final Uint8List? imageBytes;
  final Alignment imageAlignment;
  final String name;
  final String address;
  final String distance;
  final double rating;
  final int reviewCount;
  final List<String> amenities;
  final Color cardColor;
  final bool isOpen;
  final bool isUserAdded;

  ImageProvider get imageProvider {
    if (imagePath.startsWith('assets/')) {
      return AssetImage(imagePath);
    }

    if (imageBytes != null) {
      return MemoryImage(imageBytes!);
    }

    if (kIsWeb) {
      return const AssetImage('assets/images/pottypal-logo.webp');
    }

    return FileImage(File(imagePath));
  }

  Restroom({
    required this.imageColor,
    required this.imagePath,
    this.imageBytes,
    this.imageAlignment = Alignment.center,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.amenities,
    required this.cardColor,
    required this.isOpen,
    this.isUserAdded = false,
  });
}
