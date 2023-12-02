import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/feature/characters/data/models/character_model.dart';
import 'package:test_task/feature/characters/presentation/ui/character_info_screen.dart';
import 'package:test_task/feature/characters/presentation/ui/characters_screens.dart';
import 'package:test_task/feature/episodes/presentation/ui/episode_screen.dart';
import 'package:test_task/internal/helpers/bottom_nav_bar.dart';

final GoRouter routerGo = GoRouter(
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        return BottomNavBar(
          navigationShell: navigationShell,
        );
      },
      branches: <StatefulShellBranch>[
        // 1st tab
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) {
                return const CharactersScreen();
              },
              routes: <RouteBase>[],
            ),
          ],
        ),

        // 2nd tab
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/episodes',
              builder: (BuildContext context, GoRouterState state) {
                return EpisodeScreen();
              },
              routes: <RouteBase>[],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/character_info',
      builder: (BuildContext context, GoRouterState state) {
        late CharacterResult characterResult;

        if (state.extra != null) {
          final Map<String, Object> params = state.extra as Map<String, Object>;

          characterResult = params["characterResult"] as CharacterResult;
        }

        return CharacterInfoScreen(characterResult: characterResult);
      },
    )
  ],
);
