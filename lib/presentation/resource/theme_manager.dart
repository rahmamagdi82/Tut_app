import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resource/color_manager.dart';

import '../resource/font_manager.dart';
import '../resource/style_manager.dart';
import '../resource/values_Manager.dart';

ThemeData getApplicationTheme(){
  return ThemeData(

    // main colors

    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,

      //card theme

      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4,
      ),

    //appBar theme

    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.lightPrimary,
        titleTextStyle: getRegularStyle(
            fontSize: FontSize.s18,
            color: ColorManager.white,
        ),
    ),

      // elevated button them
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(
                  color: ColorManager.white, fontSize: FontSize.s17),
              primary: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12),
              ),
          ),
      ),

    //text theme

    textTheme: TextTheme(
      displaySmall: getBoldStyle(
          color: ColorManager.primary,fontSize: FontSize.s14),
      headlineMedium: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s18),
      headlineSmall: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s16),
      titleMedium: getMediumStyle(
          color: ColorManager.primary,fontSize: FontSize.s16),
      titleSmall: getMediumStyle(
          color: ColorManager.lightGrey),
      labelLarge: getRegularStyle(
            color: ColorManager.darkGrey),
      labelMedium: getRegularStyle(
            color: ColorManager.primary,fontSize: FontSize.s12),


    ),

    // input decoration theme (text form field)

    inputDecorationTheme: InputDecorationTheme(
      // content padding
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle:
        getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        labelStyle: getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border style
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),

    // bottom sheet style
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: AppSize.s1_5,
      selectedItemColor:ColorManager.primary,
      unselectedItemColor: ColorManager.lightGrey
    ),
    );


}