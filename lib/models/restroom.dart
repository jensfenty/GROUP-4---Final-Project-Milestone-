import 'package:flutter/material.dart';
import 'dart:io';

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

  ImageProvider get imageProvider {
  if (imagePath.startsWith('assets/')){
    return AssetImage(imagePath);
  } else {
    return FileImage(File(imagePath));
  }
}

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
