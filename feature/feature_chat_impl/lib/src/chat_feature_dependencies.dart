library feature_chat_impl;

import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:localization_api/localization_api.dart';

import 'chat_feature.dart';

export 'package:profile_navigation_api/profile_navigation_api.dart';

class ChatFeatureDependencies {
  const ChatFeatureDependencies({
    required this.chatRepository,
    required this.fileRepository,
    required this.userRepository,
    required this.chatMessageRepository,
    required this.routerFactory,
    required this.dateFormatter,
    required this.dateParser,
    required this.connectionStateProvider,
    required this.stringsProvider,
    required this.messagePreviewResolver,
    required this.chatHeaderInfoFeatureApi,
    required this.fileDownloader,
    required this.functionExecutor,
    required this.superGroupRepository,
    required this.basicGroupRepository,
    required this.superGroupUpdatesProvider,
    required this.basicGroupUpdatesProvider,
    required this.chatUpdatesProvider,
    required this.chatMessagesUpdatesProvider,
    required this.chatManager,
    required this.errorTransformer,
  });

  final IChatRepository chatRepository;

  final IFileRepository fileRepository;

  final IUserRepository userRepository;

  final IChatMessageRepository chatMessageRepository;

  final IChatScreenRouterFactory routerFactory;

  final DateFormatter dateFormatter;

  final DateParser dateParser;

  final IConnectionStateProvider connectionStateProvider;

  final IStringsProvider stringsProvider;

  final IMessagePreviewResolver messagePreviewResolver;

  final IChatHeaderInfoFeatureApi chatHeaderInfoFeatureApi;

  final IFileDownloader fileDownloader;

  final ITdFunctionExecutor functionExecutor;

  final ISuperGroupRepository superGroupRepository;

  final IBasicGroupRepository basicGroupRepository;

  final ISuperGroupUpdatesProvider superGroupUpdatesProvider;

  final IBasicGroupUpdatesProvider basicGroupUpdatesProvider;

  final IChatUpdatesProvider chatUpdatesProvider;

  final IChatMessagesUpdatesProvider chatMessagesUpdatesProvider;

  final IChatManager chatManager;

  final IErrorTransformer errorTransformer;
}
