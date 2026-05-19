import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../presentation/providers/auth_provider.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/closet/closet_screen.dart';
import '../presentation/screens/closet/add_item_screen.dart';
import '../presentation/screens/outfit_builder/outfit_builder_screen.dart';
import '../presentation/screens/planner/planner_screen.dart';
import '../presentation/screens/community/community_screen.dart';
import '../presentation/screens/community/create_post_page.dart';
import '../presentation/screens/profile/profile_screen.dart';

class MainShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainShell({super.key, required this.navigationShell});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.checkroom_rounded, 'label': 'Closet'},
      {'icon': Icons.calendar_month_rounded, 'label': 'Planner'},
      {'icon': Icons.people_rounded, 'label': 'Community'},
      {'icon': Icons.person_rounded, 'label': 'Profile'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.06 * 255).round()),
            blurRadius: 20,
            offset: const Offset(0, -4),
          )
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: NavigationBar(
          selectedIndex: widget.navigationShell.currentIndex,
          onDestinationSelected: (i) =>
              widget.navigationShell.goBranch(i,
                  initialLocation: i == widget.navigationShell.currentIndex),
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFB8A9C9).withAlpha((0.2 * 255).round()),
          destinations: items
              .map((item) => NavigationDestination(
                    icon: Icon(item['icon'] as IconData,
                        color: const Color(0xFFAAAAAA)),
                    selectedIcon: Icon(item['icon'] as IconData,
                        color: const Color(0xFF8B7BA8)),
                    label: item['label'] as String,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isLoggedIn && !isAuthRoute) return '/login';
      if (isLoggedIn && isAuthRoute) return '/home';
      return null;
    },
    routes: [
      GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen()),
      GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen()),
      GoRoute(
          path: '/outfit-builder',
          builder: (context, state) => const OutfitBuilderScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) =>
            MainShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/closet',
              builder: (context, state) => const ClosetScreen(),
              routes: [
                GoRoute(
                    path: 'add-item',
                    builder: (context, state) => const AddItemScreen()),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/planner',
              builder: (context, state) => const PlannerScreen(),
              routes: [
                GoRoute(
                    path: 'create',
                    // ✅ OutfitBuilderScreen: выбор Top → Bottom → Shoes → Extras
                    builder: (context, state) => const OutfitBuilderScreen()),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/community',
              builder: (context, state) => const CommunityScreen(),
              routes: [
                GoRoute(
                    path: 'create-post',
                    builder: (context, state) => const CreatePostPage()),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen()),
          ]),
        ],
      ),
    ],
  );
});