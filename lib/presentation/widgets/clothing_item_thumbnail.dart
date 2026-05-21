import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ClothingItemThumbnail extends StatelessWidget {
  final String? imagePath;
  final String emoji;
  final double size;
  final double borderRadius;
  final Color backgroundColor;

  const ClothingItemThumbnail({
    super.key,
    required this.imagePath,
    required this.emoji,
    this.size = 56,
    this.borderRadius = 12,
    this.backgroundColor = const Color(0xFFF5F0F8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (imagePath != null && imagePath!.isNotEmpty) {
      // On web imagePath is stored as a data URL or file path –
      // kIsWeb check lets us handle both platforms gracefully.
      if (kIsWeb) {
        return Image.network(
          imagePath!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _emoji(),
        );
      } else {
        final file = File(imagePath!);
        if (file.existsSync()) {
          return Image.file(
            file,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _emoji(),
          );
        }
      }
    }
    return _emoji();
  }

  Widget _emoji() => Center(
        child: Text(
          emoji,
          style: TextStyle(fontSize: size * 0.5),
        ),
      );
}
