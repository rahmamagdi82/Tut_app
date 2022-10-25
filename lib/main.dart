import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tut_app/presentation/resource/language_manager.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(supportedLocales: const [ENGLISH_LOCAL,ARABIC_LOCAL], path: ASSET_PATH_LOCALIZATIONS, child: Phoenix( child: MyApp(),)),
      );
}



