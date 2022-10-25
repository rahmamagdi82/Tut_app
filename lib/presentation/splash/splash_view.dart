import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resource/assets_manager.dart';
import 'package:tut_app/presentation/resource/color_manager.dart';
import 'package:tut_app/presentation/resource/constants_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../resource/routes_manager.dart';

class SplashView extends StatefulWidget{
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPrefs _appPrefs = instance<AppPrefs>();
  Timer? _timer;
  _startDelay(){
    _timer=Timer(const Duration(seconds: ConstantsManager.splashDelay), _goNext);
  }
  _goNext() {
      if (_appPrefs.getData(key: PREFS_KEY_ONBOARDING) ?? false) {
        if (_appPrefs.getData(key: PREFS_KEY_LOGIN) ?? false) {
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
        } else {
          Navigator.pushReplacementNamed(context, Routes.loginRoute);
        }
      } else {
        Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
      }
  }

  @override
  void initState(){
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(
          image: AssetImage(AssetsManager.splashLogo),
        ),
      ),
    );
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }

}