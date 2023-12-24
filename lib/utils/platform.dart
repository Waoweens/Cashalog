import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

import 'package:flutter/material.dart';

bool get isWeb => kIsWeb;
bool get isDesktop =>
    Platform.isWindows ||
    Platform.isLinux ||
    Platform.isMacOS ||
    Platform.isFuchsia;

bool get isMobile => Platform.isAndroid || Platform.isIOS;

bool isNonTouchDevice = isDesktop || isWeb;

Widget nonTouchRefreshButton(refresh) {
  return isNonTouchDevice
      ? Center(
          child: SizedBox(
              height: 24.0,
              width: 24.0,
              child: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: refresh,
                  icon: const Icon(
                    Icons.refresh,
                    size: 24.0,
                  ))))
      : const SizedBox.shrink();
}
