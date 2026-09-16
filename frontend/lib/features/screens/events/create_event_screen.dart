import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 4) {
            setState(() => _currentStep += 1);
          } else {
            // Submit form
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Event Published Successfully!')));
            Navigator.pop(context);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          }
        },
        steps: [
          Step(
            title: const Text('Details'),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: Column(
              children: [
                TextFormField(decoration: const InputDecoration(labelText: 'Event Title', border: OutlineInputBorder())),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'Education', child: Text('Education')),
                    DropdownMenuItem(value: 'Health', child: Text('Health')),
                    DropdownMenuItem(value: 'Environment', child: Text('Environment')),
                  ],
                  onChanged: (v) {},
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Time'),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            content: Column(
              children: [
                TextFormField(decoration: const InputDecoration(labelText: 'Date (DD/MM/YYYY)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.calendar_today))),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: TextFormField(decoration: const InputDecoration(labelText: 'Start Time', border: OutlineInputBorder(), prefixIcon: Icon(Icons.access_time)))),
                    const SizedBox(width: 16),
                    Expanded(child: TextFormField(decoration: const InputDecoration(labelText: 'End Time', border: OutlineInputBorder(), prefixIcon: Icon(Icons.access_time)))),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(decoration: const InputDecoration(labelText: 'Location / Venue', border: OutlineInputBorder(), prefixIcon: Icon(Icons.location_on))),
              ],
            ),
          ),
          Step(
            title: const Text('Volunteers'),
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            content: Column(
              children: [
                TextFormField(decoration: const InputDecoration(labelText: 'Volunteer Capacity', border: OutlineInputBorder()), keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                TextFormField(decoration: const InputDecoration(labelText: 'Required Skills (comma separated)', border: OutlineInputBorder())),
              ],
            ),
          ),
          Step(
            title: const Text('Impact'),
            isActive: _currentStep >= 3,
            state: _currentStep > 3 ? StepState.complete : StepState.indexed,
            content: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Impact Metric', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'Trees Planted', child: Text('Trees Planted')),
                    DropdownMenuItem(value: 'People Reached', child: Text('People Reached')),
                    DropdownMenuItem(value: 'Meals Served', child: Text('Meals Served')),
                  ],
                  onChanged: (v) {},
                ),
                const SizedBox(height: 16),
                TextFormField(decoration: const InputDecoration(labelText: 'Target Value', border: OutlineInputBorder()), keyboardType: TextInputType.number),
              ],
            ),
          ),
          Step(
            title: const Text('Review'),
            isActive: _currentStep >= 4,
            content: const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('Review your event details carefully before publishing to the network.', textAlign: TextAlign.center),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
