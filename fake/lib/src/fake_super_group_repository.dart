import 'dart:async';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class FakeSuperGroupRepository implements ISuperGroupRepository {
  @override
  Future<td.Supergroup> getGroup(int id) {
    return Completer<td.Supergroup>().future;
  }

  @override
  Future<td.SupergroupFullInfo> getGroupFullInfo(int id) {
    return Completer<td.SupergroupFullInfo>().future;
  }
}
