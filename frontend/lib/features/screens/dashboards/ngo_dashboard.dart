import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../shared/widgets/shared_widgets.dart';

class NgoDashboard extends StatelessWidget {
  const NgoDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Management'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.calendar_month), onPressed: () {}),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: () {
              context.push('/ngo/events/create');
            },
            icon: const Icon(Icons.add),
            label: const Text('Create Event'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create, coordinate and measure your NGO\'s social-impact events.', 
                 style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600])),
            const SizedBox(height: 24),
            
            // KPI Cards Grid
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.5,
                  children: const [
                    StatCard(title: 'Total Events', value: '142', icon: Icons.event, iconColor: Colors.blue),
                    StatCard(title: 'Active Events', value: '12', icon: Icons.play_circle, iconColor: Colors.green, trendText: '+2', isTrendUp: true),
                    StatCard(title: 'Total Registrations', value: '3,450', icon: Icons.group, iconColor: Colors.purple, trendText: '+15%', isTrendUp: true),
                    StatCard(title: 'Avg. Attendance', value: '85%', icon: Icons.check_circle, iconColor: Colors.teal),
                  ],
                );
              }
            ),
            const SizedBox(height: 32),

            // Charts Section
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildStatusChartCard(context)),
                      const SizedBox(width: 16),
                      Expanded(flex: 2, child: _buildTrendChartCard(context)),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildStatusChartCard(context),
                      const SizedBox(height: 16),
                      _buildTrendChartCard(context),
                    ],
                  );
                }
              }
            ),
            const SizedBox(height: 32),

            // Volunteer Capacity Alerts
            const SectionHeader(title: 'Attention Required'),
            const SizedBox(height: 16),
            _buildAttentionCard(context, 'Beach Cleanup Drive', 'Only 12/50 volunteers registered (24% filled). Starts in 2 days!'),

            const SizedBox(height: 32),

            // Upcoming Events List
            SectionHeader(
              title: 'Upcoming Events', 
              actionText: 'View All',
              onActionPressed: () {},
            ),
            const SizedBox(height: 16),
            _buildEventListItem(context, 'Mega Tree Plantation Drive', 'Tomorrow, 08:00 AM', 'Mumbai', 120, 500, 'Registration Open'),
            _buildEventListItem(context, 'Weekend Education for All', 'Saturday, 10:00 AM', 'Dharavi', 18, 20, 'Filling Fast'),

          ],
        ),
      ),
    );
  }

  Widget _buildStatusChartCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Event Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(color: Colors.blue, value: 40, title: '40%', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    PieChartSectionData(color: Colors.green, value: 30, title: '30%', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    PieChartSectionData(color: Colors.orange, value: 15, title: '15%', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    PieChartSectionData(color: Colors.grey, value: 15, title: '15%', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Legend(color: Colors.blue, text: 'Completed'),
                _Legend(color: Colors.green, text: 'Active'),
                _Legend(color: Colors.orange, text: 'Draft'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTrendChartCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Registration Trend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                DropdownButton<String>(
                  value: '30 Days',
                  items: ['7 Days', '30 Days', '3 Months'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) {},
                  underline: const SizedBox(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 10), FlSpot(1, 25), FlSpot(2, 20),
                        FlSpot(3, 45), FlSpot(4, 30), FlSpot(5, 60),
                        FlSpot(6, 85),
                      ],
                      isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: true, color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttentionCard(BuildContext context, String eventTitle, String issue) {
    return Card(
      elevation: 0,
      color: Colors.orange.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.orange.withOpacity(0.5))),
      child: ListTile(
        leading: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 32),
        title: Text(eventTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(issue),
        trailing: FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.orange),
          onPressed: () {},
          child: const Text('Promote'),
        ),
      ),
    );
  }

  Widget _buildEventListItem(BuildContext context, String title, String time, String location, int currentVols, int maxVols, String status) {
    double progress = currentVols / maxVols;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network('https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=200', width: 80, height: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), overflow: TextOverflow.ellipsis)),
                      StatusChip(label: status, color: status == 'Registration Open' ? Colors.green : Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('$time • $location', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[200],
                          color: progress > 0.8 ? Colors.green : Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('$currentVols / $maxVols Vols', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text('View Details')),
                const PopupMenuItem(child: Text('Manage Volunteers')),
                const PopupMenuItem(child: Text('Mark Attendance')),
                const PopupMenuItem(child: Text('Edit Event')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String text;
  const _Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
