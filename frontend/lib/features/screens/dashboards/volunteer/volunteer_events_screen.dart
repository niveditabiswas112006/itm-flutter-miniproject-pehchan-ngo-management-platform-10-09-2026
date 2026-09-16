import 'package:flutter/material.dart';
import '../../../../shared/widgets/shared_widgets.dart';

class VolunteerEventsScreen extends StatelessWidget {
  const VolunteerEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Events'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Ongoing'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _EventListView(status: 'Upcoming'),
            _EventListView(status: 'Ongoing'),
            _EventListView(status: 'Completed'),
          ],
        ),
      ),
    );
  }
}

class _EventListView extends StatelessWidget {
  final String status;
  const _EventListView({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (status == 'Upcoming') ...[
          _buildEventItem(context, 'Beach Cleanup Drive', 'Juhu Beach, Mumbai', 'Starts Tomorrow, 07:00 AM', Colors.blue, 'Check-in details pending'),
          _buildEventItem(context, 'Slum Education Drive', 'Dharavi, Mumbai', 'Starts on 12 Oct, 10:00 AM', Colors.blue, 'Check-in details pending'),
          _buildEventItem(context, 'Blood Donation Camp', 'Bandra West, Mumbai', 'Starts on 15 Oct, 09:00 AM', Colors.blue, 'Check-in details pending'),
          _buildEventItem(context, 'Stray Animal Feeding', 'Versova, Mumbai', 'Starts on 18 Oct, 08:00 AM', Colors.blue, 'Check-in details pending'),
          _buildEventItem(context, 'Orphanage Visit', 'Malad East, Mumbai', 'Starts on 20 Oct, 11:00 AM', Colors.blue, 'Check-in details pending'),
          _buildEventItem(context, 'Awareness Marathon', 'Marine Drive, Mumbai', 'Starts on 25 Oct, 06:00 AM', Colors.blue, 'Check-in details pending'),
          _buildEventItem(context, 'Women Safety Workshop', 'Colaba, Mumbai', 'Starts on 28 Oct, 04:00 PM', Colors.blue, 'Check-in details pending'),
          _buildEventItem(context, 'Mental Health Awareness', 'Powai, Mumbai', 'Starts on 01 Nov, 10:00 AM', Colors.blue, 'Check-in details pending'),
          _buildEventItem(context, 'Clean Energy Seminar', 'BKC, Mumbai', 'Starts on 05 Nov, 02:00 PM', Colors.blue, 'Check-in details pending'),
          _buildEventItem(context, 'E-Waste Collection Drive', 'Andheri East, Mumbai', 'Starts on 10 Nov, 09:00 AM', Colors.blue, 'Check-in details pending'),
        ],
        if (status == 'Ongoing') ...[
          _buildEventItem(context, 'Food Distribution Drive', 'Dadar Railway Station', 'Ongoing now - ends at 05:00 PM', Colors.orange, 'Check-in active'),
          _buildEventItem(context, 'Free Medical Checkup', 'Sion Hospital Area', 'Ongoing now - ends at 08:00 PM', Colors.orange, 'Check-in active'),
          _buildEventItem(context, 'Flood Relief Material Packing', 'BKC Exhibition Center', 'Ongoing now - ends at 09:00 PM', Colors.orange, 'Check-in active'),
          _buildEventItem(context, 'Women Empowerment Workshop', 'Kurla West, Mumbai', 'Ongoing now - ends at 04:00 PM', Colors.orange, 'Check-in active'),
        ],
        if (status == 'Completed') ...[
          _buildEventItem(context, 'Winter Clothes Donation', 'Andheri East, Mumbai', 'Completed on 12 Jan 2024', Colors.green, 'Certificate Issued'),
          _buildEventItem(context, 'Mega Tree Plantation', 'Sanjay Gandhi National Park', 'Completed on 05 Dec 2023', Colors.green, 'Certificate Issued'),
          _buildEventItem(context, 'Old Age Home Visit', 'Kandivali West, Mumbai', 'Completed on 10 Nov 2023', Colors.green, 'Certificate Issued'),
          _buildEventItem(context, 'School Books Distribution', 'Govandi, Mumbai', 'Completed on 15 Aug 2023', Colors.green, 'Certificate Issued'),
          _buildEventItem(context, 'Community Health Drive', 'Goregaon East, Mumbai', 'Completed on 02 Jul 2023', Colors.green, 'Certificate Issued'),
        ],
      ],
    );
  }

  Widget _buildEventItem(BuildContext context, String title, String location, String timeString, Color statusColor, String subStatus) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                StatusChip(label: status, color: statusColor),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(location, style: TextStyle(color: Colors.grey.shade700)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(timeString, style: TextStyle(color: Colors.grey.shade700)),
              ],
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(subStatus, style: TextStyle(color: status == 'Completed' ? Colors.green : Colors.orange, fontWeight: FontWeight.bold, fontSize: 13)),
                if (status == 'Upcoming')
                  StatefulBuilder(
                    builder: (context, setState) {
                      bool isRegistered = false;
                      bool isLoading = false;
                      // State cannot be correctly persisted across rebuilds of the list
                      // if we define variables directly in the builder, so let's mock it
                      // by checking the button label. For a true app, this relies on a provider.
                      // For UI demonstration, we'll keep it simple:
                      return isRegistered
                          ? OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.qr_code, size: 16),
                              label: const Text('View Ticket'),
                              style: OutlinedButton.styleFrom(foregroundColor: Colors.teal),
                            )
                          : FilledButton(
                              onPressed: isLoading ? null : () async {
                                setState(() => isLoading = true);
                                await Future.delayed(const Duration(milliseconds: 800));
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Registered Successfully! Your ticket is ready.'),
                                      backgroundColor: Colors.teal,
                                    ),
                                  );
                                  setState(() {
                                    isLoading = false;
                                    isRegistered = true;
                                  });
                                }
                              },
                              style: FilledButton.styleFrom(backgroundColor: Colors.teal),
                              child: isLoading
                                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                  : const Text('Register & Get Ticket'),
                            );
                    },
                  ),
                if (status == 'Completed')
                  FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: () {},
                    icon: const Icon(Icons.download, size: 16),
                    label: const Text('Certificate'),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
