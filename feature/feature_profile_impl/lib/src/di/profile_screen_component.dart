import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/feature_profile_impl.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_bloc.dart';
import 'package:feature_profile_impl/src/screen/profile/content_interactor.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(modules: <Type>[ProfileScreenModule])
abstract class ProfileScreenComponent {
  IChatHeaderInfoFactory getChatHeaderInfoFactory();

  ProfileBloc getProfileBloc();

  ILocalizationManager getLocalizationManager();
}

@j.module
abstract class ProfileScreenModule {
  @j.provide
  @j.singleton
  static IChatHeaderInfoInteractor provideChatHeaderInfoInteractor(
    ProfileArgs args,
    ProfileFeatureDependencies dependencies,
  ) =>
      dependencies.chatHeaderInfoFeatureApi
          .getChatHeaderInfoInteractor(args.id);

  @j.provide
  @j.singleton
  static IChatHeaderInfoFactory provideChatHeaderInfoFactory(
    ProfileArgs args,
    ProfileFeatureDependencies dependencies,
  ) =>
      dependencies.chatHeaderInfoFeatureApi.getChatHeaderInfoFactory();

  @j.provide
  @j.singleton
  static ProfileBloc provideProfileBloc(
    ProfileArgs args,
    ProfileFeatureDependencies dependencies,
    ContentInteractor contentInteractor,
  ) =>
      ProfileBloc(
        args: args,
        headerInfoInteractor: dependencies.chatHeaderInfoFeatureApi
            .getChatHeaderInfoInteractor(args.id),
        contentInteractor: contentInteractor,
        messageRepository: dependencies.messageRepository,
      );

  @j.provide
  @j.singleton
  static ContentInteractor provideContentInteractor(
    ProfileArgs args,
    ProfileFeatureDependencies dependencies,
  ) =>
      ContentInteractor(
        args: args,
        localizationManager: dependencies.localizationManager,
        chatRepository: dependencies.chatRepository,
        userRepository: dependencies.userRepository,
        basicGroupRepository: dependencies.basicGroupRepository,
        superGroupRepository: dependencies.superGroupRepository,
        messageRepository: dependencies.messageRepository,
      );

  @j.provide
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
    ProfileFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager;
}

@j.componentBuilder
abstract class ProfileScreenComponentBuilder {
  ProfileScreenComponentBuilder dependencies(
    ProfileFeatureDependencies dependencies,
  );

  ProfileScreenComponentBuilder chatArgs(ProfileArgs args);

  ProfileScreenComponent build();
}
