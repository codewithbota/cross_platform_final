# 👗 Fashion Closet & Outfit Planner

**Group:** SE-2420  
**Participants:** Nazly Beisenbek · Altynay Zhumagazykyzy · Kamila Melsova · Akbota Karimolda  
**University:** Astana IT University

---

## About the Project

Fashion Closet & Outfit Planner is a Flutter application that helps users manage their wardrobe, build outfits, plan what to wear each day of the week, and share their looks with a community. The app uses Firebase for authentication and cloud storage, Drift (SQLite) for local data, and the OpenWeatherMap API to display weather on the home screen.

---

## Team Contributions

| Participant | Branch | Responsibility |
|---|---|---|
| **Kamila Melsova** | `feature/kamila-auth-home` | Firebase Auth (login & register screens), Home Screen, Weather API integration |
| **Altynay Zhumagazykyzy** | `feature/altynai-closet-db` | My Closet screen, Add Item screen, Drift database schema & migrations |
| **Nazly Beisenbek** | `feature/nazly-outfits-planner` | Outfit Builder screen, Planner screen, Riverpod state for outfits & weekly plan |
| **Akbota Karimolda** | `feature/akbota-community-profile` | Community screen, Create Post page, Profile screen, Firestore integration |

---

## Features

- **Authentication** — Email/password sign-up and login via Firebase Auth
- **My Closet** — Add, browse, and filter clothing items by category and season; photos stored locally
- **Outfit Builder** — Step-by-step outfit creation (Top → Bottom → Shoes → Extras)
- **Weekly Planner** — Assign an outfit to each day of the week; auto-creates 7 entries every Monday
- **Community Feed** — Share outfits as posts, like others' posts, delete your own; real-time updates via Firestore
- **Profile** — Edit username and handle, toggle dark/light theme, sign out
- **Weather Widget** — Current weather on the Home screen fetched from OpenWeatherMap

---

## Tech Stack

| Layer | Technology |
|---|---|
| UI Framework | Flutter + Material 3 |
| State Management | Flutter Riverpod (`StreamProvider`, `StateNotifierProvider`) |
| Navigation | GoRouter (declarative, sub-routes, auth redirect) |
| Local Database | Drift / SQLite (schema v3, DAO pattern) |
| Cloud Database | Cloud Firestore |
| Authentication | Firebase Auth |
| Networking | `http` package — OpenWeatherMap API |
| Lightweight Storage | Shared Preferences (dark mode toggle) |
| Fonts | Google Fonts (Poppins) |
| Code Generation | `build_runner` + Drift codegen |

---

## Architecture

The project follows **Clean Architecture** with three layers:

```
lib/
├── app/
│   └── router.dart           # GoRouter — all routes & auth redirect
├── domain/
│   ├── models/               # Pure Dart models (ClothingItem, Outfit, PlannerEntry, CommunityPost, WeatherModel)
│   └── repositories/         # Abstract repository interfaces
├── data/
│   ├── local/                # Drift database, DAOs (ClothingDao, OutfitDao, PlannerDao)
│   ├── remote/               # WeatherService (HTTP), FirestoreService
│   └── repositories/         # Repository implementations
├── presentation/
│   ├── providers/            # Riverpod providers (auth, database, planner, community, theme, weather)
│   ├── screens/              # UI screens grouped by feature
│   └── widgets/              # Reusable widgets (OutfitCard, ClothingItemThumbnail)
├── firebase_options.dart
└── main.dart
```

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- A Firebase project with **Authentication** (Email/Password) and **Firestore** enabled
- An [OpenWeatherMap](https://openweathermap.org/api) API key

### 1. Clone the repository

```bash
git clone https://github.com/codewithbota/cross_platform_final
cd fashion-closet
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

Run FlutterFire CLI to generate `lib/firebase_options.dart` for your project:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Or replace the existing `lib/firebase_options.dart` with the one generated for your Firebase project.

### 4. Add your OpenWeatherMap API key

In `lib/presentation/providers/weather_provider.dart`, set your API key:

```dart
final weatherServiceProvider = Provider((ref) =>
    WeatherService(apiKey: '52eedef491f293e0028f150a49d705a7'));
```

### 5. Run code generation (Drift)

The Drift database files (`*.g.dart`) are auto-generated. After any schema change, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 6. Run the app

```bash
flutter run
```

---

## Key Implementation Details

### Navigation — GoRouter

All routes are declared in `lib/app/router.dart`. The router watches `authStateProvider` and automatically redirects unauthenticated users to `/login`. A `StatefulShellRoute` powers the bottom navigation bar with five branches: Home, Closet, Planner, Community, and Profile.

### State Management — Riverpod

- `authStateProvider` — `StreamProvider<User?>` listening to `FirebaseAuth.authStateChanges()`
- `clothingItemsProvider` / `outfitsProvider` — `StreamProvider` backed by Drift reactive queries
- `weekPlanProvider` — `StateNotifierProvider` managing the 7-day planner, auto-creating entries for the current week
- `communityPostsProvider` — `StreamProvider` backed by Firestore real-time snapshots
- `themeProvider` — `StateNotifierProvider` persisting dark mode preference via Shared Preferences

### Local Persistence — Drift

`AppDatabase` (schema version 3) defines three tables: `ClothingItems`, `Outfits`, and `PlannerEntries`. All tables include a `userId` column so each user sees only their own data. Migrations handle upgrades from older schema versions.

### Cloud — Firestore

Community posts are stored in a `posts` collection and user profiles in a `users` collection. `FirestoreService` uses `FieldValue.arrayUnion` / `arrayRemove` for atomic like/unlike operations. On Windows, a polling fallback (every 4 seconds) is used instead of real-time snapshots due to a platform plugin limitation.

### External API — OpenWeatherMap

`WeatherService` makes a `GET` request to `https://api.openweathermap.org/data/2.5/weather` with `units=metric`. The JSON response is deserialized into a `WeatherModel` using a generated `fromJson` method.

### Lightweight Settings — Shared Preferences

`ThemeNotifier` reads and writes the `isDarkMode` boolean key via `SharedPreferences`, persisting the user's theme choice across sessions.

---
