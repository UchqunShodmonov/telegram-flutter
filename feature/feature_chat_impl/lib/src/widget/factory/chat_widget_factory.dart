import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/screen/chat/bloc/chat_bloc.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_page.dart';
import 'package:feature_chat_impl/src/tile/model/message_tile_model.dart';
import 'package:feature_chat_impl/src/tile/widget/message_tile_adapter_delegate.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message.dart';
import 'package:feature_chat_impl/src/widget/chat_message/content/add_members_tile_factory.dart';
import 'package:feature_chat_impl/src/widget/chat_message/content/message_text_content_factory.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class ChatWidgetFactory implements IChatWidgetFactory {
  ChatWidgetFactory({required this.dependencies});

  final IChatFeatureDependencies dependencies;

  @override
  Widget create(int chatId) {
    final ChatArgs chatArgs = ChatArgs(chatId);
    final MessageTextContentFactory messageTextContentFactory =
        MessageTextContentFactory();
    final tg.AvatarWidgetFactory avatarWidgetFactory =
        tg.AvatarWidgetFactory(fileRepository: dependencies.fileRepository);
    final AddMembersTileFactory addMembersTileFactory = AddMembersTileFactory();
    final ChatMessageFactory chatMessageFactory = ChatMessageFactory(
        messageTextFactory: messageTextContentFactory,
        avatarWidgetFactory: avatarWidgetFactory,
        addMembersFactory: addMembersTileFactory);
    return MultiProvider(
      providers: <Provider<dynamic>>[
        Provider<tg.ListAdapter>.value(
            value: tg.ListAdapter(
                delegates: <Type, tg.IListAdapterDelegate<tg.ITileModel>>{
              MessageTileModel: MessageTileAdapterDelegate(
                  chatMessageFactory: chatMessageFactory),
            })),
        Provider<ChatMessageFactory>.value(value: chatMessageFactory),
        Provider<ILocalizationManager>.value(
            value: dependencies.localizationManager),
        Provider<tg.ConnectionStateWidgetFactory>.value(
            value: tg.ConnectionStateWidgetFactory(
                connectionStateProvider: dependencies.connectionStateProvider))
      ],
      child: BlocProvider<ChatBloc>(
          create: (BuildContext context) => ChatBloc(
                router: dependencies.router,
                messagesInteractor: ChatMessagesInteractor(
                    chatRepository: dependencies.chatRepository,
                    chatArgs: chatArgs,
                    messageRepository: dependencies.chatMessageRepository),
                args: chatArgs,
              ),
          child: const ChatPage()),
    );
  }
}