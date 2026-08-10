import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Configuration for MOE Notify package.
class MoeNotifyConfig {
  final bool enablePushNotifications;
  final String channelId;
  final String channelName;

  const MoeNotifyConfig({
    this.enablePushNotifications = true,
    this.channelId = 'moe_default_channel',
    this.channelName = 'MOE Notifications',
  });
}

/// Provider for notify config.
final notifyConfigProvider = Provider<MoeNotifyConfig>((ref) {
  return MoeNotify.config;
});

/// Setup function — call in main() before runApp().
class MoeNotify {
  static late MoeNotifyConfig _config;

  static void setup({required MoeNotifyConfig config}) {
    _config = config;
  }

  static MoeNotifyConfig get config => _config;
}
