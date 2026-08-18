# MOE-Flutter-Notify

Notification package for MOE Flutter ecosystem â€” push notification, in-app notification, multi-channel.

## Installation

```yaml
dependencies:
  moe_flutter_notify:
    git:
      url: https://github.com/mindofemanizer/MOE-Flutter-Notify.git
      ref: v1.0.0
```

## Usage

### Setup

```dart
import 'package:moe_flutter_foundation/moe_flutter_foundation.dart';
import 'package:moe_flutter_notify/moe_flutter_notify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  await MoeFoundation.setup(
    envConfig: EnvConfig.fromEnvironment(),
    sharedPreferences: prefs,
  );

  MoeNotify.setup(
    config: MoeNotifyConfig(
      enablePushNotifications: true,
      channelId: 'moe_chat_channel',
      channelName: 'Chat Notifications',
    ),
  );

  runApp(MoeFoundationProviderScope(child: MyApp()));
}
```

### In-App Notifications

```dart
final state = ref.watch(inAppNotificationsProvider);

switch (state) {
  case InAppNotificationsLoaded(:final notifications):
    ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (ctx, i) => Dismissible(
        key: Key(notifications[i].id),
        background: Container(color: _colorForType(notifications[i].type)),
        child: ListTile(
          leading: Icon(notifications[i].type.iconData),
          title: Text(notifications[i].title),
          subtitle: Text(notifications[i].message),
          isThreeLine: true,
          trailing: notifications[i].isRead
              ? null
              : CircleAvatar(radius: 6, backgroundColor: Colors.red),
        ),
        onDismissed: (_) => 
            ref.read(inAppNotificationsProvider.notifier).markAsRead(notifications[i].id),
      ),
    );
  default:
    // loading/error
}

// trigger load
ref.read(inAppNotificationsProvider.notifier).load();

// get unread count
final unread = ref.read(inAppNotificationsProvider.notifier).unreadCount;
```

### What's Included

| Module | Description |
|--------|-------------|
| `NotificationType` | Built-in types + icon colors |
| `InAppNotificationModel` | Data model |
| `InAppNotificationsNotifier` | Load, mark as read, unread count |
