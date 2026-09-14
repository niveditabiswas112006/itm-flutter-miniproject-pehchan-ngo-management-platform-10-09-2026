import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Placeholder screen imports until implemented
import '../../features/screens/home/landing_screen.dart';
import '../../features/screens/dashboards/volunteer/volunteer_shell.dart';
import '../../features/screens/dashboards/volunteer/volunteer_overview_screen.dart';
import '../../features/screens/dashboards/volunteer/volunteer_events_screen.dart';
import '../../features/screens/dashboards/volunteer/volunteer_wallet_screen.dart';
import '../../features/screens/dashboards/volunteer/volunteer_certificates_screen.dart';
import '../../features/screens/dashboards/ngo_dashboard.dart';
import '../../features/screens/dashboards/admin_dashboard.dart';
import '../../features/screens/certificates/certificate_verifier_screen.dart';
import '../../features/screens/events/create_event_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return VolunteerShellScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/volunteer/overview',
          builder: (context, state) => const VolunteerOverviewScreen(),
        ),
        GoRoute(
          path: '/volunteer/events',
          builder: (context, state) => const VolunteerEventsScreen(),
        ),
        GoRoute(
          path: '/volunteer/wallet',
          builder: (context, state) => const VolunteerWalletScreen(),
        ),
        GoRoute(
          path: '/volunteer/certificates',
          builder: (context, state) => const VolunteerCertificatesScreen(),
        ),
      ],
    ),
    // Redirect old dashboard link to overview
    GoRoute(
      path: '/volunteer/dashboard',
      redirect: (context, state) => '/volunteer/overview',
    ),
    GoRoute(
      path: '/ngo/dashboard',
      builder: (context, state) => const NgoDashboard(),
    ),
    GoRoute(
      path: '/ngo/events/create',
      builder: (context, state) => const CreateEventScreen(),
    ),
    GoRoute(
      path: '/admin/dashboard',
      builder: (context, state) => const AdminDashboard(),
    ),
    GoRoute(
      path: '/verify',
      builder: (context, state) => const CertificateVerifierScreen(),
    ),
    GoRoute(
      path: '/verify/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return CertificateVerifierScreen(certificateId: id);
      },
    ),
  ],
);
