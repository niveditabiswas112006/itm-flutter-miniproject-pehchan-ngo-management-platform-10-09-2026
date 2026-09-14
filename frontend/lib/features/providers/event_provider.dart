import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/models/enums.dart';
import '../../shared/models/models.dart';
import '../../core/network/api_client.dart';

final eventsProvider = FutureProvider<List<SocialEvent>>((ref) async {
  try {
    final response = await ApiClient.get('/events');
    final List data = response['data'] ?? [];
    
    return data.map((e) => SocialEvent(
      id: e['id'] ?? '',
      ngoId: e['ngoId'] ?? '',
      ngoName: e['ngoName'] ?? '',
      ngoLogo: e['ngoLogo'] ?? '',
      title: e['title'] ?? '',
      description: e['description'] ?? '',
      category: _parseCategory(e['category']),
      coverImageUrl: e['coverImageUrl'] ?? '',
      date: DateTime.tryParse(e['date']?.toString() ?? '') ?? DateTime.now(),
      startTime: e['startTime'] ?? '',
      endTime: e['endTime'] ?? '',
      location: e['location'] ?? '',
      maxVolunteers: e['maxVolunteers'] ?? 0,
      currentVolunteerCount: e['currentVolunteerCount'] ?? 0,
      requiredSkills: List<String>.from(e['requiredSkills'] ?? []),
      status: _parseStatus(e['status']),
      createdAt: DateTime.tryParse(e['createdAt']?.toString() ?? '') ?? DateTime.now(),
    )).toList();
  } catch (e) {
    print("Error fetching events: $e");
    return [];
  }
});

final featuredEventsProvider = FutureProvider<List<SocialEvent>>((ref) async {
  final allEvents = await ref.watch(eventsProvider.future);
  return allEvents.take(2).toList();
});

final eventProvider = FutureProvider.family<SocialEvent?, String>((ref, id) async {
  final allEvents = await ref.watch(eventsProvider.future);
  try {
    return allEvents.firstWhere((element) => element.id == id);
  } catch (e) {
    return null;
  }
});

EventCategory _parseCategory(String? category) {
  if (category == 'education') return EventCategory.education;
  if (category == 'bloodDonation') return EventCategory.bloodDonation;
  return EventCategory.treePlantation;
}

EventStatus _parseStatus(String? status) {
  if (status == 'registrationClosed') return EventStatus.registrationClosed;
  if (status == 'ongoing') return EventStatus.ongoing;
  if (status == 'completed') return EventStatus.completed;
  if (status == 'cancelled') return EventStatus.cancelled;
  return EventStatus.registrationOpen;
}
