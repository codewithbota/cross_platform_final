import 'package:flutter/material.dart';
import '../../domain/models/outfit.dart';
import 'clothing_item_thumbnail.dart';

class OutfitCard extends StatelessWidget {
  final Outfit outfit;
  final VoidCallback? onDelete;
  const OutfitCard({super.key, required this.outfit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 150,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClothingItemThumbnail(
                imagePath: outfit.topImagePath,
                emoji: outfit.topEmoji,
                size: 48,
                borderRadius: 10,
              ),
              const SizedBox(width: 4),
              ClothingItemThumbnail(
                imagePath: outfit.bottomImagePath,
                emoji: outfit.bottomEmoji,
                size: 48,
                borderRadius: 10,
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClothingItemThumbnail(
            imagePath: outfit.shoesImagePath,
            emoji: outfit.shoesEmoji,
            size: 48,
            borderRadius: 10,
          ),
          const SizedBox(height: 8),
          Text(
            outfit.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          if (outfit.isFavorite)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.favorite, color: Color(0xFFB8A9C9), size: 14),
            ),
        ],
      ),
          ),
          if (onDelete != null)
            Positioned(
              top: 4,
              right: 4,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.delete_outline_rounded, size: 18),
                onPressed: onDelete,
              ),
            ),
        ],
      );
  }
}
