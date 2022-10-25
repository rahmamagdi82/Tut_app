import 'package:flutter/material.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';

enum LanguageType{
  ENGLISH,
  ARABIC
}

const String ENGLISH="en";
const String ARABIC="ar";
const String ASSET_PATH_LOCALIZATIONS="assets/translation";

const Locale ENGLISH_LOCAL= Locale("en","US");
const Locale ARABIC_LOCAL= Locale("ar","SA");

extension LanguageTypeExtention on LanguageType{
  String getValue(){
    switch(this){
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}

final AppPrefs _appPrefs=instance<AppPrefs>();
Future<String> getAppLanguage() async {
  String? language = _appPrefs.getData(key: PREFS_KEY_LANG);
  if (language != null) {
    return language;
  } else {
    // return default lang
    return LanguageType.ENGLISH.getValue();
  }
}

Future<Locale> getLocal() async {
  String currentLang = await getAppLanguage();

  if (currentLang == LanguageType.ARABIC.getValue()) {
    return ARABIC_LOCAL;
  } else {
    return ENGLISH_LOCAL;
  }
}