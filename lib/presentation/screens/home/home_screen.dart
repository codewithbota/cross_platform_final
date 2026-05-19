// lib/presentation/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../providers/database_provider.dart';
import '../../providers/weather_provider.dart';
import '../../widgets/outfit_card.dart';
import '../../../domain/models/clothing_item.dart';
import '../../../domain/models/outfit.dart';
import '../../../domain/models/weather_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final outfitsAsync = ref.watch(outfitsProvider);
    final clothingItemsAsync = ref.watch(clothingItemsProvider);
    final weatherAsync = ref.watch(weatherProvider(kDefaultCity));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: const Color(0xFFFAF8F5),
            expandedHeight: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good morning 👋',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                Text(
                  user?.email?.split('@').first ?? 'Your style overview',
                  style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                ),
              ],
            ),
            actions: [
              IconButton(
                  icon: const Icon(Icons.notifications_none_rounded),
                  onPressed: () {}),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Weather card
                const _WeatherCard(),
                const SizedBox(height: 20),

                // Today's outfit
                const _SectionTitle(title: "Today's Outfit ✨"),
                const SizedBox(height: 12),
                clothingItemsAsync.when(
                  data: (items) {
                    final suggested = _buildTodayOutfit(
                        items, weatherAsync, outfitsAsync.valueOrNull ?? []);
                    return suggested != null
                        ? _TodayOutfitCard(outfit: suggested)
                        : const _EmptyOutfitCard();
                  },
                  loading: () => const SizedBox(
                      height: 120,
                      child: Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFFB8A9C9)))),
                  error: (_, __) => outfitsAsync.when(
                    data: (outfits) => outfits.isEmpty
                        ? const _EmptyOutfitCard()
                        : _TodayOutfitCard(outfit: outfits.first),
                    loading: () => const SizedBox(
                        height: 120,
                        child: Center(
                            child: CircularProgressIndicator(
                                color: Color(0xFFB8A9C9)))),
                    error: (_, __) => const _EmptyOutfitCard(),
                  ),
                ),
                const SizedBox(height: 20),

                // Quick actions
                const _SectionTitle(title: 'Quick Actions'),
                const SizedBox(height: 12),
                const _QuickActions(),
                const SizedBox(height: 20),

                // My outfits
                const _SectionTitle(title: 'My Outfits', showSeeAll: true),
                const SizedBox(height: 12),
                outfitsAsync.when(
                  data: (outfits) => SizedBox(
                    height: 180,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: outfits.isEmpty ? 1 : outfits.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, i) {
                        if (outfits.isEmpty) {
                          return const _EmptyOutfitCard();
                        }
                        return OutfitCard(outfit: outfits[i]);
                      },
                    ),
                  ),
                  loading: () => const SizedBox(height: 180),
                  error: (_, __) => const SizedBox(height: 180),
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

Outfit? _buildTodayOutfit(
  List<ClothingItem> items,
  AsyncValue<WeatherModel> weatherAsync,
  List<Outfit> savedOutfits,
) {
      final tops = items.where((item) => item.category == 'Tops').toList();
      final bottoms = items.where((item) => item.category == 'Bottoms').toList();
      final shoes = items.where((item) => item.category == 'Shoes').toList();

  if (tops.isEmpty || bottoms.isEmpty || shoes.isEmpty) {
    return savedOutfits.isNotEmpty ? savedOutfits.first : null;
  }

  final weather = weatherAsync.maybeWhen(
    data: (weather) => weather,
    orElse: () => null,
  );

  final selectedTop = _pickTopForWeather(tops, weather);
  final selectedBottom = bottoms.first;
  final selectedShoes = shoes.first;

  return Outfit(
    id: 'suggested-${selectedTop.id}-${selectedBottom.id}-${selectedShoes.id}',
    name: _weatherTitle(weather),
    topId: selectedTop.id,
    bottomId: selectedBottom.id,
    shoesId: selectedShoes.id,
    createdAt: DateTime.now(),
    top: selectedTop.name,
    bottom: selectedBottom.name,
    shoes: selectedShoes.name,
    topEmoji: selectedTop.emoji,
    bottomEmoji: selectedBottom.emoji,
    shoesEmoji: selectedShoes.emoji,
  );
}

ClothingItem _pickTopForWeather(
  List<ClothingItem> tops,
  WeatherModel? weather,
) {
  if (weather != null && weather.main.temp <= 12) {
    return tops.firstWhere(
      (item) {
        final label = item.name.toLowerCase();
        return label.contains('coat') ||
            label.contains('jacket') ||
            label.contains('sweater') ||
            label.contains('hoodie');
      },
      orElse: () => tops.first,
    );
  }
  if (weather != null && weather.main.temp >= 25) {
    return tops.firstWhere(
      (item) {
        final label = item.name.toLowerCase();
        return label.contains('tank') ||
            label.contains('tee') ||
            label.contains('shirt') ||
            label.contains('dress');
      },
      orElse: () => tops.first,
    );
  }
  return tops.first;
}

String _weatherTitle(WeatherModel? weather) {
  if (weather == null) return 'Today\'s outfit';
  final temp = weather.main.temp;
  if (temp < 8) return 'Cozy winter-ready look';
  if (temp < 18) return 'Fresh layers for cool weather';
  if (temp < 26) return 'Light style for warm weather';
  return 'Breezy outfit for a sunny day';
}

class _WeatherCard extends ConsumerWidget {
  const _WeatherCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider(kDefaultCity));

    return weatherAsync.when(
      data: (weather) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF9BB8D4), Color(0xFFB8A9C9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${weather.name}, KZ',
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text('${weather.main.temp.toStringAsFixed(0)}°C',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold)),
                  Text(weather.weather.isNotEmpty
                      ? weather.weather.first.description
                      : 'Weather unavailable',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha((0.2 * 255).round()),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Feels like ${weather.main.feelsLike.toStringAsFixed(0)}°',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12)),
                  )
                ],
              ),
            ),
            const Text('⛅', style: TextStyle(fontSize: 64)),
          ],
        ),
      ),
      loading: () => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF9BB8D4), Color(0xFFB8A9C9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        ),
      ),
      error: (error, _) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF9BB8D4), Color(0xFFB8A9C9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Astana, KZ',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            const Text('22°C',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold)),
            const Text('Unable to load weather',
                style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 8),
            Text(error.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _TodayOutfitCard extends StatelessWidget {
  final Outfit outfit;
  const _TodayOutfitCard({required this.outfit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).round()),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome,
                  color: Color(0xFFB8A9C9), size: 18),
              const SizedBox(width: 6),
              Text('Suggested for today',
                  style: TextStyle(
                      color: Colors.grey[500], fontSize: 13)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFB8A9C9).withAlpha((0.15 * 255).round()),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Spring',
                    style: TextStyle(
                        color: Color(0xFF8B7BA8), fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(outfit.name,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _OutfitPiece(emoji: outfit.topEmoji, label: outfit.top),
              _OutfitPiece(
                  emoji: outfit.bottomEmoji, label: outfit.bottom),
              _OutfitPiece(
                  emoji: outfit.shoesEmoji, label: outfit.shoes),
            ],
          ),
        ],
      ),
    );
  }
}

class _OutfitPiece extends StatelessWidget {
  final String emoji;
  final String label;
  const _OutfitPiece({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F0F8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
              child:
                  Text(emoji, style: const TextStyle(fontSize: 32))),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(label,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                  fontSize: 11, color: Color(0xFF666666))),
        ),
      ],
    );
  }
}

class _EmptyOutfitCard extends StatelessWidget {
  const _EmptyOutfitCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFB8A9C9).withAlpha((0.08 * 255).round()),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: const Color(0xFFB8A9C9).withAlpha((0.3 * 255).round())),
      ),
      child: const Column(
        children: [
          Text('👗', style: TextStyle(fontSize: 36)),
          SizedBox(height: 8),
          Text('No outfits yet',
              style:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          SizedBox(height: 4),
          Text('Create your first outfit!',
              style: TextStyle(
                  fontSize: 13, color: Color(0xFFB8A9C9))),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final actions = [
      {
        'icon': Icons.add_circle_rounded,
        'label': 'Add Item',
        'color': const Color(0xFFB8A9C9),
        'route': '/closet/add-item'
      },
      {
        'icon': Icons.checkroom_rounded,
        'label': 'My Closet',
        'color': const Color(0xFFE8C4B8),
        'route': '/closet'
      },
      {
        'icon': Icons.auto_awesome_rounded,
        'label': 'Build Outfit',
        'color': const Color(0xFFA8D8B9),
        'route': '/outfit-builder'
      },
      {
        'icon': Icons.calendar_today_rounded,
        'label': 'Planner',
        'color': const Color(0xFF9BB8D4),
        'route': '/planner'
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((a) {
        return GestureDetector(
          onTap: () {
            final route = a['route'] as String;
            if (route == '/outfit-builder') {
              context.push(route);
            } else {
              context.go(route);
            }
          },
          child: Container(
            width: 78,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withAlpha((0.04 * 255).round()),
                    blurRadius: 8,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (a['color'] as Color).withAlpha((0.15 * 255).round()),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(a['icon'] as IconData,
                      color: a['color'] as Color, size: 20),
                ),
                const SizedBox(height: 8),
                Text(a['label'] as String,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final bool showSeeAll;
  const _SectionTitle({required this.title, this.showSeeAll = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600)),
        if (showSeeAll)
          TextButton(
            onPressed: () {},
            child: const Text('See all',
                style: TextStyle(
                    color: Color(0xFF8B7BA8), fontSize: 13)),
          ),
      ],
    );
  }
}

