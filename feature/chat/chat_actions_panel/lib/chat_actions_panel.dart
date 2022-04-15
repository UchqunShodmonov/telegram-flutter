library chat_actions_panel;

import 'package:chat_actions_panel/src/panel_state.dart';
import 'package:flutter/widgets.dart';

export 'src/chat_action_panel_factory.dart';
// todo move implementation to separated module
export 'src/chat_action_panel_interactor.dart';
export 'src/panel_state.dart';

abstract class IChatActionPanelFactory {
  Widget create(PanelState state);
}

abstract class IActionsListener {
  void onToggleMuteState({required bool newState});
  void onJoin();
}

abstract class IChatActionPanelInteractor {
  Stream<PanelState> get panelStateStream;

  void dispose();
}
