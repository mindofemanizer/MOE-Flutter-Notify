import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:moe_flutter_core/moe_flutter_core.dart';
import 'package:moe_flutter_notify/src/models/notification_model.dart';

/// State for in-app notifications.
sealed class InAppNotificationsState {
  const InAppNotificationsState();
}

final class InAppNotificationsInitial extends InAppNotificationsState {
  const InAppNotificationsInitial();
}

final class InAppNotificationsLoaded extends InAppNotificationsState {
  final List<InAppNotificationModel> notifications;
  const InAppNotificationsLoaded(this.notifications);
}

final class InAppNotificationsError extends InAppNotificationsState {
  final AppFailure failure;
  const InAppNotificationsError(this.failure);
}

/// Notifier for in-app notifications.
class InAppNotificationsNotifier
    extends StateNotifier<InAppNotificationsState> {
  InAppNotificationsNotifier(Ref _) : super(const InAppNotificationsInitial());

  Future<void> load() async {
    // Mock implementation — replace with API call when available
    state = const InAppNotificationsLoaded([]);
  }

  Future<void> markAsRead(String notificationId) async {
    if (state is! InAppNotificationsLoaded) return;

    final loaded = state as InAppNotificationsLoaded;
    final updated = loaded.notifications.map((n) {
      if (n.id == notificationId) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();

    state = InAppNotificationsLoaded(updated);
  }

  Future<void> markAllAsRead() async {
    if (state is! InAppNotificationsLoaded) return;

    final loaded = state as InAppNotificationsLoaded;
    final updated =
        loaded.notifications.map((n) => n.copyWith(isRead: true)).toList();

    state = InAppNotificationsLoaded(updated);
  }

  int get unreadCount {
    if (state is! InAppNotificationsLoaded) return 0;
    return (state as InAppNotificationsLoaded)
        .notifications
        .where((n) => !n.isRead)
        .length;
  }
}

/// Provider for InAppNotificationsNotifier.
final inAppNotificationsProvider =
    StateNotifierProvider<InAppNotificationsNotifier, InAppNotificationsState>(
        (ref) {
  return InAppNotificationsNotifier(ref);
});
