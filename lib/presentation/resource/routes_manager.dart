import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/forget_password/view/forget_password_view.dart';
import 'package:tut_app/presentation/login/view/login_view.dart';
import 'package:tut_app/presentation/main/view/main_view/main_view.dart';
import 'package:tut_app/presentation/onboarding/view/onboarding_view.dart';
import 'package:tut_app/presentation/register/view/register_view.dart';
import 'package:tut_app/presentation/resource/string_manager.dart';
import 'package:tut_app/presentation/splash/splash_view.dart';

import '../../app/di.dart';
import '../store_details/view/store_details.dart';

class Routes{
  static const String splashRoute="/";
  static const String loginRoute="/login";
  static const String registerRoute="/register";
  static const String forgetPasswordRoute="/forgetPassword";
  static const String onBoardingRoute="/onBoarding";
  static const String mainRoute="/main";
  static const String storeDetailsRoute="/storeDetails";
}

class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_)=>SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_)=>LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_)=>RegisterView());
      case Routes.forgetPasswordRoute:
        initForgetPasswordModule();
        return MaterialPageRoute(builder: (_)=>ForgetPasswordView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_)=>OnBoardingView());
      case Routes.mainRoute:
        initHomeModule();
        initNotificationsModule();
        return MaterialPageRoute(builder: (_)=>MainView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_)=>StoreDetailsView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.noRouteFound.tr()),
          ),
          body: Center(child: Text(AppStrings.noRouteFound.tr())),
        ));
  }
}