import 'package:flutter/material.dart';
import '../../domain/models/outfit.dart';

class OutfitCard extends StatelessWidget {
  final Outfit outfit;
  const OutfitCard({super.key, required this.outfit});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(outfit.topEmoji, style: const TextStyle(fontSize: 24)),
              Text(outfit.bottomEmoji, style: const TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: 4),
          Text(outfit.shoesEmoji, style: const TextStyle(fontSize: 24)),
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
              child: Icon(Icons.favorite,
                  color: Color(0xFFB8A9C9), size: 14),
            ),
        ],
      ),
    );
  }
}