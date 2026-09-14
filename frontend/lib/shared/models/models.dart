import 'package:equatable/equatable.dart';
import 'enums.dart';

class AppUser extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profileImageUrl;
  final UserRole role;
  final String city;
  final String bio;
  final VolunteerType? volunteerType;
  final List<EventCategory> preferredCategories;
  final List<String> skills;
  final int totalHours;
  final int completedEventsCount;
  final DateTime createdAt;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
    required this.role,
    required this.city,
    required this.bio,
    this.volunteerType,
    this.preferredCategories = const [],
    this.skills = const [],
    this.totalHours = 0,
    this.completedEventsCount = 0,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, role, totalHours, completedEventsCount];
}

class NGOProfile extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String registrationNumber;
  final bool verified;
  final String logoUrl;
  final String coverUrl;
  final String description;
  final String phone;
  final String email;
  final String website;
  final String city;
  final String address;
  final double currentBalance;
  final double totalDonationsReceived;
  final double totalExpensesIncurred;
  final int activeEventsCount;
  final int totalVolunteersCount;

  const NGOProfile({
    required this.id,
    required this.userId,
    required this.name,
    required this.registrationNumber,
    required this.verified,
    required this.logoUrl,
    required this.coverUrl,
    required this.description,
    required this.phone,
    required this.email,
    required this.website,
    required this.city,
    required this.address,
    this.currentBalance = 0.0,
    this.totalDonationsReceived = 0.0,
    this.totalExpensesIncurred = 0.0,
    this.activeEventsCount = 0,
    this.totalVolunteersCount = 0,
  });

  @override
  List<Object?> get props => [id, verified, currentBalance, activeEventsCount, totalVolunteersCount];
}

class SocialEvent extends Equatable {
  final String id;
  final String ngoId;
  final String ngoName;
  final String ngoLogo;
  final String title;
  final String description;
  final EventCategory category;
  final String coverImageUrl;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String location;
  final int maxVolunteers;
  final int currentVolunteerCount;
  final List<String> requiredSkills;
  final EventStatus status;
  final DateTime createdAt;

  const SocialEvent({
    required this.id,
    required this.ngoId,
    required this.ngoName,
    required this.ngoLogo,
    required this.title,
    required this.description,
    required this.category,
    required this.coverImageUrl,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.maxVolunteers,
    this.currentVolunteerCount = 0,
    required this.requiredSkills,
    this.status = EventStatus.registrationOpen,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, status, currentVolunteerCount];
}

class EventRegistration extends Equatable {
  final String id;
  final String eventId;
  final String eventTitle;
  final String ngoId;
  final String userId;
  final String userName;
  final String userEmail;
  final String userPhone;
  final VolunteerType volunteerType;
  final RegistrationStatus status;
  final DateTime registeredAt;
  final DateTime? attendedAt;
  final String? certificateId;

  const EventRegistration({
    required this.id,
    required this.eventId,
    required this.eventTitle,
    required this.ngoId,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.volunteerType,
    this.status = RegistrationStatus.registered,
    required this.registeredAt,
    this.attendedAt,
    this.certificateId,
  });

  @override
  List<Object?> get props => [id, status, certificateId];
}

class Certificate extends Equatable {
  final String id;
  final String certificateNo;
  final String userId;
  final String userName;
  final String eventId;
  final String eventTitle;
  final EventCategory category;
  final String ngoId;
  final String ngoName;
  final String ngoLogo;
  final DateTime issueDate;
  final int hoursContributed;
  final bool verified;
  final String signatureName;
  final String signatureRole;

  const Certificate({
    required this.id,
    required this.certificateNo,
    required this.userId,
    required this.userName,
    required this.eventId,
    required this.eventTitle,
    required this.category,
    required this.ngoId,
    required this.ngoName,
    required this.ngoLogo,
    required this.issueDate,
    required this.hoursContributed,
    this.verified = true,
    required this.signatureName,
    required this.signatureRole,
  });

  @override
  List<Object?> get props => [id, certificateNo, verified];
}

class MoneyDonation extends Equatable {
  final String id;
  final String donorId;
  final String donorName;
  final String ngoId;
  final String ngoName;
  final double amount;
  final String currency;
  final String purpose;
  final DonationStatus status;
  final String transactionReference;
  final DateTime createdAt;

  const MoneyDonation({
    required this.id,
    required this.donorId,
    required this.donorName,
    required this.ngoId,
    required this.ngoName,
    required this.amount,
    this.currency = 'INR',
    required this.purpose,
    this.status = DonationStatus.successful,
    required this.transactionReference,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, status];
}

class WalletTransaction extends Equatable {
  final String id;
  final String ngoId;
  final TransactionType type;
  final double amount;
  final String category;
  final String description;
  final String referenceId;
  final String createdBy;
  final DateTime createdAt;

  const WalletTransaction({
    required this.id,
    required this.ngoId,
    required this.type,
    required this.amount,
    required this.category,
    required this.description,
    required this.referenceId,
    required this.createdBy,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id];
}
