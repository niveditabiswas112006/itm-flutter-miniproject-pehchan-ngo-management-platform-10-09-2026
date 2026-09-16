enum UserRole {
  guest,
  volunteer,
  ngo,
  admin,
}

enum VolunteerType {
  eventSpecific,
  lifetime,
}

enum EventStatus {
  draft,
  published,
  registrationOpen,
  registrationClosed,
  ongoing,
  completed,
  cancelled,
}

enum EventCategory {
  treePlantation,
  plasticAwareness,
  bloodDonation,
  education,
  foodDistribution,
  animalWelfare,
  womenEmpowerment,
  disasterRelief,
  communityCleanliness,
  healthAwareness,
  other,
}

enum RegistrationStatus {
  registered,
  approved,
  attended,
  completed,
  rejected,
}

enum DonationStatus {
  pending,
  successful,
  failed,
}

enum MaterialCondition {
  brandNew,
  likeNew,
  good,
  fair,
}

enum MaterialDonationStatus {
  pending,
  received,
  distributed,
}

enum ExpenseStatus {
  pending,
  approved,
  rejected,
  paid,
}

enum ExpenseCategory {
  eventMaterials,
  transportation,
  food,
  medicalSupplies,
  equipment,
  venue,
  administration,
  other,
}

enum TransactionType {
  donation,
  expense,
  refund,
  adjustment,
}

enum NotificationType {
  info,
  success,
  warning,
  alert,
}
