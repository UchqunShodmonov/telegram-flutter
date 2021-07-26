import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:flutter/material.dart';

class ChatHeaderInfoFactory {
  ChatHeaderInfoFactory({
    required tg.ConnectionStateWidgetFactory connectionStateWidgetFactory,
    required tg.AvatarWidgetFactory avatarWidgetFactory,
  })  : _avatarWidgetFactory = avatarWidgetFactory,
        _connectionStateWidgetFactory = connectionStateWidgetFactory;

  final tg.ConnectionStateWidgetFactory _connectionStateWidgetFactory;
  final tg.AvatarWidgetFactory _avatarWidgetFactory;

  Widget create({required BuildContext context, required ChatHeaderInfo info}) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: _avatarWidgetFactory.create(
          context,
          radius: 20,
          chatId: info.chatId,
          imageId: info.photoId,
        ),
        title: Text(
          info.title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: _connectionStateWidgetFactory.create(context, (_) {
            return Text(
              info.subtitle,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.white54),
            );
          }),
        ));
  }
}
