import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;
import 'util/td_error_ext.dart';

class TdFunctionExecutor implements ITdFunctionExecutor {
  TdFunctionExecutor({
    required TdClient client,
  }) : _client = client;

  final TdClient _client;

  @override
  Future<T> execute<T extends td.TdObject>(td.TdFunction object) =>
      _client.execute<T>(object).catchTdError();

  @override
  Future<T> send<T extends td.TdObject>(td.TdFunction object) =>
      _client.send<T>(object).catchTdError();
}