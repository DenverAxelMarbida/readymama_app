// lib/core/router/app_router.dart
//
// Central GoRouter configuration.
// - Five-tab shell (dashboard, assessment, hospital bag, emergency, profile).
// - /assessment/results is nested in the assessment branch (bottom nav stays
//   visible); /reminders is a root-level route (full screen, no bottom nav).

import 'package:go_router/go_router.dart';

import 'package:readymama_app/core/router/app_shell.dart';
import 'package:readymama_app/features/assessment/presentation/assessment_results_screen.dart';
import 'package:readymama_app/features/assessment/presentation/assessment_screen.dart';
import 'package:readymama_app/features/dashboard/presentation/dashboard_screen.dart';
import 'package:readymama_app/features/emergency/presentation/emergency_screen.dart';
import 'package:readymama_app/features/hospital_bag/presentation/hospital_bag_screen.dart';
import 'package:readymama_app/features/profile/presentation/profile_screen.dart';
import 'package:readymama_app/features/reminders/presentation/reminders_screen.dart';

abstract final class Routes {
  static const String dashboard = '/';
  static const String assessment = '/assessment';
  static const String assessmentResults = '/assessment/results';
  static const String hospitalBag = '/hospital-bag';
  static const String emergency = '/emergency';
  static const String reminders = '/reminders';
  static const String profile = '/profile';
}

abstract final class RouteNames {
  static const String dashboard = 'dashboard';
  static const String assessment = 'assessment';
  static const String assessmentResults = 'assessmentResults';
  static const String hospitalBag = 'hospitalBag';
  static const String emergency = 'emergency';
  static const String reminders = 'reminders';
  static const String profile = 'profile';
}

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.dashboard,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.dashboard,
              name: RouteNames.dashboard,
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.assessment,
              name: RouteNames.assessment,
              builder: (context, state) => const AssessmentScreen(),
              routes: [
                GoRoute(
                  path: 'results',
                  name: RouteNames.assessmentResults,
                  builder: (context, state) => const AssessmentResultsScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.hospitalBag,
              name: RouteNames.hospitalBag,
              builder: (context, state) => const HospitalBagScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.emergency,
              name: RouteNames.emergency,
              builder: (context, state) => const EmergencyScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profile,
              name: RouteNames.profile,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: Routes.reminders,
      name: RouteNames.reminders,
      builder: (context, state) => const RemindersScreen(),
    ),
  ],
);