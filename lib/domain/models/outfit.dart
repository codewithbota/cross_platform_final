class Outfit {
  final String id;
  final String name;
  final String topId;
  final String bottomId;
  final String shoesId;
  final String? accessoryId;
  final DateTime createdAt;
  bool isFavorite;

  final String top;
  final String bottom;
  final String shoes;
  final String accessory;
  final String topEmoji;
  final String bottomEmoji;
  final String shoesEmoji;
  final String? topImagePath;
  final String? bottomImagePath;
  final String? shoesImagePath;

  Outfit({
    required this.id,
    required this.name,
    required this.topId,
    required this.bottomId,
    required this.shoesId,
    this.accessoryId,
    required this.createdAt,
    this.isFavorite = false,
    this.top = '',
    this.bottom = '',
    this.shoes = '',
    this.accessory = '',
    this.topEmoji = '👕',
    this.bottomEmoji = '👖',
    this.shoesEmoji = '👟',
    this.topImagePath,
    this.bottomImagePath,
    this.shoesImagePath,
  });

  Outfit copyWith({bool? isFavorite}) {
    return Outfit(
      id: id,
      name: name,
      topId: topId,
      bottomId: bottomId,
      shoesId: shoesId,
      accessoryId: accessoryId,
      createdAt: createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
      top: top,
      bottom: bottom,
      shoes: shoes,
      accessory: accessory,
      topEmoji: topEmoji,
      bottomEmoji: bottomEmoji,
      shoesEmoji: shoesEmoji,
      topImagePath: topImagePath,
      bottomImagePath: bottomImagePath,
      shoesImagePath: shoesImagePath,
    );
  }
}
