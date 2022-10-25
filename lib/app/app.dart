import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/resource/routes_manager.dart';
import 'package:tut_app/presentation/resource/theme_manager.dart';

import '../presentation/resource/language_manager.dart';

class MyApp extends StatefulWidget{

  MyApp._internal();
  static final MyApp _instance = MyApp._internal();
  factory MyApp()=> _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AppPrefs _appPrefs=instance<AppPrefs>();

  @override
  void didChangeDependencies() async {
    Locale local=await getLocal();
    context.setLocale(local);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}