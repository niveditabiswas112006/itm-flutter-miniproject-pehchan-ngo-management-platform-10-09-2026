import 'package:equatable/equatable.dart';
import 'enums.dart';
import 'models.dart';

class MaterialDonation extends Equatable {
  final String id;
  final String donorId;
  final String donorName;
  final String ngoId;
  final String ngoName;
  final String itemName;
  final String category;
  final int quantity;
  final String unit;
  final MaterialCondition condition;
  final String description;
  final String? imageUrl;
  final MaterialDonationStatus status;
  final DateTime receivedAt;

  const MaterialDonation({
    required this.id,
    required this.donorId,
    required this.donorName,
    required this.ngoId,
    required this.ngoName,
    required this.itemName,
    required this.category,
    required this.quantity,
    required this.unit,
    required this.condition,
    required this.description,
    this.imageUrl,
    this.status = MaterialDonationStatus.received,
    required this.receivedAt,
  });

  @override
  List<Object?> get props => [id, status];
}

class InventoryItem extends Equatable {
  final String id;
  final String ngoId;
  final String itemName;
  final String category;
  final int quantity;
  final String unit;
  final int lowStockThreshold;
  final DateTime lastUpdated;

  const InventoryItem({
    required this.id,
    required this.ngoId,
    required this.itemName,
    required this.category,
    required this.quantity,
    required this.unit,
    this.lowStockThreshold = 20,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [id, quantity];
}

class Expense extends Equatable {
  final String id;
  final String ngoId;
  final double amount;
  final ExpenseCategory category;
  final String description;
  final String? eventId;
  final String? eventTitle;
  final String? receiptUrl;
  final ExpenseStatus status;
  final String createdBy;
  final DateTime createdAt;

  const Expense({
    required this.id,
    required this.ngoId,
    required this.amount,
    required this.category,
    required this.description,
    this.eventId,
    this.eventTitle,
    this.receiptUrl,
    this.status = ExpenseStatus.paid,
    required this.createdBy,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, status];
}

class AuditLog extends Equatable {
  final String id;
  final String actorId;
  final String actorName;
  final UserRole actorRole;
  final String action;
  final String entityType;
  final String entityId;
  final String metadata;
  final DateTime timestamp;

  const AuditLog({
    required this.id,
    required this.actorId,
    required this.actorName,
    required this.actorRole,
    required this.action,
    required this.entityType,
    required this.entityId,
    required this.metadata,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id];
}

class PehchanNotification extends Equatable {
  final String id;
  final String recipientId;
  final UserRole targetRole;
  final String title;
  final String message;
  final NotificationType type;
  final bool read;
  final DateTime createdAt;

  const PehchanNotification({
    required this.id,
    required this.recipientId,
    required this.targetRole,
    required this.title,
    required this.message,
    this.type = NotificationType.info,
    this.read = false,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, read];
}
