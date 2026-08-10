import 'package:flutter_test/flutter_test.dart';
import 'package:moe_flutter_notify/moe_flutter_notify.dart';

void main() {
  group('NotificationType', () {
    test('has iconData for built-in types', () {
      expect(NotificationType.info.iconData, isNotNull);
      expect(NotificationType.warning.iconData, isNotNull);
      expect(NotificationType.error.iconData, isNotNull);
      expect(NotificationType.success.iconData, isNotNull);
      expect(NotificationType.custom.iconData, isNull);
    });
  });

  group('InAppNotificationModel', () {
    test('fromJson parses correctly', () {
      final json = {
        'id': '123',
        'title': 'Test Notification',
        'message': 'This is a test message',
        'type': 'info',
        'created_at': '2026-08-10T12:00:00.000Z',
        'is_read': false,
        'metadata': {'extra': 'data'},
      };

      final notification = InAppNotificationModel.fromJson(json);

      expect(notification.id, equals('123'));
      expect(notification.title, equals('Test Notification'));
      expect(notification.message, equals('This is a test message'));
      expect(notification.type, equals(NotificationType.info));
      expect(notification.timestamp.year, equals(2026));
      expect(notification.isRead, isFalse);
      expect(notification.metadata?['extra'], equals('data'));
    });

    test('toJson round-trips correctly', () {
      const model = InAppNotificationModel(
        id: 'test',
        title: 'Title',
        message: 'Message',
        type: NotificationType.warning,
        timestamp: DateTime(2026, 8, 10),
      );

      final json = model.toJson();

      expect(json['id'], equals('test'));
      expect(json['title'], equals('Title'));
      expect(json['message'], equals('Message'));
      expect(json['type'], equals('warning'));
      expect(json['created_at'], contains('2026-08-10'));
    });

    test('copyWith updates fields', () {
      const original = InAppNotificationModel(
        id: 'test',
        title: 'Title',
        message: 'Message',
        timestamp: DateTime(2026, 8, 10),
      );

      final updated = original.copyWith(title: 'Updated Title', isRead: true);

      expect(updated.id, equals('test'));
      expect(updated.title, equals('Updated Title'));
      expect(updated.isRead, isTrue);
      expect(updated.timestamp.year, equals(2026));
    });

    test('default values', () {
      const model = InAppNotificationModel(
        id: 'test',
        title: 'Title',
        message: 'Message',
        timestamp: DateTime(2026, 8, 10),
      );

      expect(model.type, equals(NotificationType.info));
      expect(model.metadata, isNull);
      expect(model.isRead, isFalse);
      expect(model.actionUrl, isNull);
    });
  });

  group('MoeNotifyConfig', () {
    test('default values', () {
      const config = MoeNotifyConfig();
      expect(config.enablePushNotifications, isTrue);
      expect(config.channelId, equals('moe_default_channel'));
      expect(config.channelName, equals('MOE Notifications'));
    });

    test('custom values', () {
      const config = MoeNotifyConfig(
        enablePushNotifications: false,
        channelId: 'custom_channel',
        channelName: 'Custom Channel',
      );
      expect(config.enablePushNotifications, isFalse);
      expect(config.channelId, equals('custom_channel'));
      expect(config.channelName, equals('Custom Channel'));
    });
  });
}
