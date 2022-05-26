import 'package:tdlib/td_api.dart' as td;

import 'message_preview_data.dart';

abstract class IMessagePreviewResolver {
  Future<MessagePreviewData> resolve(td.Message message);
}
