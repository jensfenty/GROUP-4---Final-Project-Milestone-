import 'package:flutter/material.dart';

class Restroom {
  final Color imageColor;
  final String imagePath;
  final Alignment imageAlignment;
  final String name;
  final String address;
  final String distance;
  final double rating;
  final int reviewCount;
  final List<String> amenities;
  final Color cardColor;
  final bool isOpen;

  Restroom({
    required this.imageColor,
    required this.imagePath,
    this.imageAlignment = Alignment.center,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.amenities,
    required this.cardColor,
    required this.isOpen,
  });
}
