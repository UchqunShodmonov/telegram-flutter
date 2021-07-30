import 'dart:ui';

import 'package:core/core.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:path_provider/path_provider.dart';
import 'package:presentation/src/navigation/navigation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

class AppDelegate {
  @j.inject
  AppDelegate(
      {required TdClient client,
      required INavigationRouter router,
      required IAppLifecycleStateProvider appLifecycleStateProvider,
      required IConnectivityProvider connectivityProvider,
      required OptionsManager optionsManager})
      : _router = router,
        _client = client,
        _appLifecycleStateProvider = appLifecycleStateProvider,
        _connectivityProvider = connectivityProvider,
        _optionsManager = optionsManager {
    _init();
  }

  final INavigationRouter _router;
  final IConnectivityProvider _connectivityProvider;
  final IAppLifecycleStateProvider _appLifecycleStateProvider;
  final TdClient _client;
  final OptionsManager _optionsManager;

  void onResume() {
    _optionsManager.setOnline(true);
  }

  void onPause() {
    _optionsManager.setOnline(false);
  }

  void _init() {
    _connectivityProvider.onStatusChange
        .startWith(_connectivityProvider.status)
        .listen((ConnectivityStatus status) {
      _client.send(td.SetNetworkType(type: status.toNetworkType()));
    });

    _appLifecycleStateProvider.onStateChange
        .where((AppLifecycleState state) => state == AppLifecycleState.resumed)
        .map((AppLifecycleState event) => _connectivityProvider.status)
        .listen((ConnectivityStatus event) {
      _client.send(td.SetNetworkType(type: event.toNetworkType()));
    });
    _client.events.listen((td.TdObject newEvent) async {
      if (newEvent is td.UpdateAuthorizationState) {
        if (newEvent.authorizationState
            is td.AuthorizationStateWaitTdlibParameters) {
          _client.send<td.Ok>(td.SetTdlibParameters(
              parameters: td.TdlibParameters(
                  systemVersion: '1',
                  useTestDc: false,
                  useSecretChats: false,
                  useMessageDatabase: true,
                  useFileDatabase: true,
                  useChatInfoDatabase: true,
                  ignoreFileNames: true,
                  enableStorageOptimizer: true,
                  filesDirectory: (await getApplicationSupportDirectory()).path,
                  databaseDirectory:
                      (await getApplicationSupportDirectory()).path,
                  systemLanguageCode: 'en',
                  deviceModel: 'pixel',
                  applicationVersion: '1.0.0',
                  apiId: 0,
                  apiHash: '')));
        } else if (newEvent.authorizationState
            is td.AuthorizationStateWaitEncryptionKey) {
          _client.send<td.Ok>(td.CheckDatabaseEncryptionKey(
              encryptionKey: 'mostrandomencryption'));
        } else if (newEvent.authorizationState is td.AuthorizationStateReady) {
          _router.toRoot();
        } else if (newEvent.authorizationState
            is td.AuthorizationStateWaitPhoneNumber) {
          _router.toLogin();
        }
      }
    });
  }
}
