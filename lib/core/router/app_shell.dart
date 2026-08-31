// lib/core/router/app_shell.dart
//
// Bottom navigation shell hosting the five top-level tabs via
// StatefulNavigationShell (state is preserved when switching tabs).

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:readymama_app/core/i18n/app_i18n.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) =>
            navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.space_dashboard_outlined),
            selectedIcon: const Icon(Icons.space_dashboard),
            label: AppI18n.t('nav.dashboard'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.quiz_outlined),
            selectedIcon: const Icon(Icons.quiz),
            label: AppI18n.t('nav.assessment'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.luggage_outlined),
            selectedIcon: const Icon(Icons.luggage),
            label: AppI18n.t('nav.hospital_bag'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.emergency_outlined),
            selectedIcon: const Icon(Icons.emergency),
            label: AppI18n.t('nav.emergency'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: AppI18n.t('nav.profile'),
          ),
        ],
      ),
    );
  }
}