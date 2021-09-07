import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:tdlib/td_api.dart' as td;

import '../util/minithumbnail.dart';

extension MinithumbnailExtensions on Minithumbnail {
  MemoryImage? toMemoryImage() => MemoryImage(data!);

  double aspectRatio() => width / height;
}

extension TdMinithumbnailExtensions on td.Minithumbnail {
  Minithumbnail? toMinithumbnail() {
    return Minithumbnail(
      data: const Base64Decoder().convert(data),
      width: width.toDouble(),
      height: height.toDouble(),
    );
  }
}
