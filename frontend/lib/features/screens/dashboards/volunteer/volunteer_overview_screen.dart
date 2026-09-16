import 'package:flutter/material.dart';
import '../../../../shared/widgets/shared_widgets.dart';

class VolunteerOverviewScreen extends StatelessWidget {
  const VolunteerOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
          const SizedBox(width: 8),
          const CircleAvatar(
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile & Welcome Section
            _buildWelcomeCard(context),
            const SizedBox(height: 32),

            // KPIs
            const SectionHeader(title: 'My Impact'),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.5,
                  children: const [
                    StatCard(title: 'Total Hours', value: '45.5', icon: Icons.schedule, iconColor: Colors.blue),
                    StatCard(title: 'Events Completed', value: '12', icon: Icons.event_available, iconColor: Colors.green),
                    StatCard(title: 'Certificates Earned', value: '10', icon: Icons.workspace_premium, iconColor: Colors.amber),
                  ],
                );
              }
            ),
            const SizedBox(height: 32),

            // Recommended Events
            SectionHeader(
              title: 'Recommended Events Near You',
              actionText: 'View All',
              onActionPressed: () {},
            ),
            const SizedBox(height: 16),
            _buildRecommendedEventCard(context, 'Save the Lakes Campaign', 'Tomorrow, 07:00 AM', 'Powai Lake, Mumbai', 'Environment', Colors.teal),
            _buildRecommendedEventCard(context, 'Blood Donation Drive', 'Saturday, 10:00 AM', 'City Hospital', 'Health', Colors.red),

          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade700, Colors.teal.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.teal.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: const Text('LIFETIME VOLUNTEER', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                ),
                const SizedBox(height: 12),
                const Text('Welcome back, Nivedita!', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('You are making a difference. Check out new opportunities today.', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // A placeholder illustration
          Icon(Icons.volunteer_activism, size: 80, color: Colors.white.withOpacity(0.8)),
        ],
      ),
    );
  }

  Widget _buildRecommendedEventCard(BuildContext context, String title, String time, String location, String category, Color categoryColor) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.park, color: categoryColor, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusChip(label: category, color: categoryColor),
                  const SizedBox(height: 8),
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(time, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(location, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () {},
              child: const Text('Join'),
            ),
          ],
        ),
      ),
    );
  }
}
