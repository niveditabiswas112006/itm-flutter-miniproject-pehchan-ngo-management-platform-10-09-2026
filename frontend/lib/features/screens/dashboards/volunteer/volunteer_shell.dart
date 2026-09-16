import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VolunteerShellScreen extends StatelessWidget {
  final Widget child;
  
  const VolunteerShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (int index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Overview'),
          NavigationDestination(icon: Icon(Icons.event_outlined), selectedIcon: Icon(Icons.event), label: 'Events'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), selectedIcon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.workspace_premium_outlined), selectedIcon: Icon(Icons.workspace_premium), label: 'Certificates'),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/volunteer/events')) return 1;
    if (location.startsWith('/volunteer/wallet')) return 2;
    if (location.startsWith('/volunteer/certificates')) return 3;
    return 0; // Default to overview
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/volunteer/overview');
        break;
      case 1:
        context.go('/volunteer/events');
        break;
      case 2:
        context.go('/volunteer/wallet');
        break;
      case 3:
        context.go('/volunteer/certificates');
        break;
    }
  }
}
