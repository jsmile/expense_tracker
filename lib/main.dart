import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/app.dart';

void main() {
  ansiColorDisabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  // 선언된 것들만 허용함.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 세로 보기만 허용.
  ]).then((value) {
    runApp(
      const App(),
    );
  });
}
