class ClothingItem {
  final String id;
  final String name;
  final String category; // Tops / Bottoms / Shoes / Bags / Accessories / Outerwear
  final String color;
  final String season; // Spring / Summer / Fall / Winter / All
  final String? imagePath;
  final String? notes;
  final String emoji;

  const ClothingItem({
    required this.id,
    required this.name,
    required this.category,
    required this.color,
    required this.season,
    this.imagePath,
    this.notes,
    this.emoji = '👕',
  });

  ClothingItem copyWith({
    String? id,
    String? name,
    String? category,
    String? color,
    String? season,
    String? imagePath,
    String? notes,
    String? emoji,
  }) {
    return ClothingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      color: color ?? this.color,
      season: season ?? this.season,
      imagePath: imagePath ?? this.imagePath,
      notes: notes ?? this.notes,
      emoji: emoji ?? this.emoji,
    );
  }
}