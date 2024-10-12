import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    required this.width, // Lebar dari widget
    required this.height, // Tinggi dari widget
    required this.shapeBorder, // Bentuk border dari widget
  });

  final double width; // Menyimpan lebar dari widget
  final double height; // Menyimpan tinggi dari widget
  final ShapeBorder shapeBorder; // Menyimpan bentuk border dari widget

  // Konstruktor untuk membuat ShimmerWidget berbentuk persegi panjang
  ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity, // Lebar default adalah maksimum
    required this.height, // Tinggi harus diisi
  }) : shapeBorder = RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14)); // Bentuk border melingkar

  // Konstruktor untuk membuat ShimmerWidget berbentuk lingkaran
  const ShimmerWidget.circular({
    super.key,
    required this.width, // Lebar harus diisi
    required this.height, // Tinggi harus diisi
    this.shapeBorder = const CircleBorder(), // Bentuk default adalah lingkaran
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300, // Warna dasar untuk efek shimmer
      highlightColor: Colors.grey.shade200, // Warna sorotan untuk efek shimmer
      child: Container(
        width: width, // Mengatur lebar container
        height: height, // Mengatur tinggi container
        decoration: ShapeDecoration(
          shape: shapeBorder, // Mengatur bentuk border container
          color: Colors.grey, // Warna latar belakang container
        ),
      ),
    );
  }
}
