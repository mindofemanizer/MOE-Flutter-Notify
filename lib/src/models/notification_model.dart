import 'package:flutter/material.dart';

/// Notification type enum.
enum NotificationType {
  info,
  warning,
  error,
  success,
  custom;

  /// Icon color for Material theme.
  IconData? get iconData {
    switch (this) {
      case NotificationType.info:
        return Icons.info_outline;
      case NotificationType.warning:
        return Icons.warning_amber_rounded;
      case NotificationType.error:
        return Icons.error_outline;
      case NotificationType.success:
        return Icons.check_circle_outline;
      case NotificationType.custom:
        return null;
    }
  }
}

/// In-app notification data model.
class InAppNotificationModel {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;
  final bool isRead;
  final String? actionUrl;

  const InAppNotificationModel({
    required this.id,
    required this.title,
    required this.message,
    this.type = NotificationType.info,
    required this.timestamp,
    this.metadata,
    this.isRead = false,
    this.actionUrl,
  });

  factory InAppNotificationModel.fromJson(Map<String, dynamic> json) {
    return InAppNotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: switch (json['type']) {
        'info' => NotificationType.info,
        'warning' => NotificationType.warning,
        'error' => NotificationType.error,
        'success' => NotificationType.success,
        _ => NotificationType.info,
      },
      timestamp: DateTime.parse(json['created_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
      isRead: json['is_read'] as bool? ?? false,
      actionUrl: json['action_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'message': message,
        'type': switch (type) {
          NotificationType.info => 'info',
          NotificationType.warning => 'warning',
          NotificationType.error => 'error',
          NotificationType.success => 'success',
          NotificationType.custom => 'custom',
        },
        'created_at': timestamp.toIso8601String(),
        if (metadata != null) 'metadata': metadata,
        'is_read': isRead,
        if (actionUrl != null) 'action_url': actionUrl,
      };

  InAppNotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    NotificationType? type,
    DateTime? timestamp,
    Map<String, dynamic>? metadata,
    bool? isRead,
    String? actionUrl,
  }) {
    return InAppNotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata ?? this.metadata,
      isRead: isRead ?? this.isRead,
      actionUrl: actionUrl ?? this.actionUrl,
    );
  }
}
