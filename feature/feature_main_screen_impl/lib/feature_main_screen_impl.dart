library feature_main_screen_impl;

import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:flutter/widgets.dart';
import 'src/di/main_screen_component.dart';

import 'src/screen/main_page.dart';

class MainScreenFeatureApi implements IMainScreenFeatureApi {
  MainScreenFeatureApi({required this.dependencies})
      : _screenWidgetFactory = _ScreenWidgetFactory(dependencies: dependencies);

  final IMainScreenWidgetFactory _screenWidgetFactory;

  final IMainScreenFeatureDependencies dependencies;

  @override
  IMainScreenWidgetFactory get screenWidgetFactory => _screenWidgetFactory;
}

abstract class IMainScreenFeatureDependencies {
  IGlobalSearchFeatureApi get globalSearchFeatureApi;

  IChatsListFeatureApi get chatsListFeatureApi;
}

class _ScreenWidgetFactory implements IMainScreenWidgetFactory {
  _ScreenWidgetFactory({required this.dependencies});

  final IMainScreenFeatureDependencies dependencies;

  @override
  Widget create() => const MainPage().wrap(dependencies);
}