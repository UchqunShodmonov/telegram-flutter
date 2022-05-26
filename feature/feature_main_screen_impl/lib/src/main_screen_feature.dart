import 'package:feature_main_screen_api/feature_main_screen_api.dart';

import 'main_screen_feature_dependencies.dart';
import 'screen/main/main_screen_factory.dart';

class MainScreenFeature implements IMainScreenFeatureApi {
  MainScreenFeature({
    required MainScreenFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final MainScreenFeatureDependencies _dependencies;
  MainScreenFactory? _mainScreenFactory;

  @override
  IMainScreenFactory get mainScreenFactory =>
      _mainScreenFactory ?? MainScreenFactory(dependencies: _dependencies);
}
