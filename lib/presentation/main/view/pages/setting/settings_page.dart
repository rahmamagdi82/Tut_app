
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/data/data_source/local_data_source.dart';
import 'package:tut_app/presentation/resource/assets_manager.dart';
import 'package:tut_app/presentation/resource/routes_manager.dart';
import 'package:tut_app/presentation/resource/string_manager.dart';
import 'package:tut_app/presentation/resource/values_Manager.dart';

import '../../../../../app/app_prefs.dart';
import '../../../../../app/di.dart';
import '../../../../resource/color_manager.dart';
import '../../../../resource/language_manager.dart';

class SettingsPage extends StatefulWidget{
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  final AppPrefs _appPrefs = instance<AppPrefs>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();


  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
    ListTile(
    leading: SvgPicture.asset(AssetsManager.settings,height: AppSize.s30,width: AppSize.s30,),
    title: Text(AppStrings.changeLanguage.tr(),style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorManager.grey1,fontSize: AppSize.s16),),
    trailing:  Icon(Icons.arrow_forward_ios,color: ColorManager.primary),
    onTap: (){
      _changeLanguage();
    },
    ),
        ListTile(
          leading: SvgPicture.asset(AssetsManager.contactUs,height: AppSize.s30,width: AppSize.s30,),
          title: Text(AppStrings.contactUs.tr(),style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorManager.grey1,fontSize: AppSize.s16),),
          trailing:  Icon(Icons.arrow_forward_ios,color: ColorManager.primary),
          onTap: (){},
        ),
        ListTile(
          leading: SvgPicture.asset(AssetsManager.inviteFriends,height: AppSize.s30,width: AppSize.s30,),
          title: Text(AppStrings.invite.tr(),style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorManager.grey1,fontSize: AppSize.s16),),
          trailing:  Icon(Icons.arrow_forward_ios,color: ColorManager.primary,),
          onTap: (){},
        ),
        ListTile(
          leading: SvgPicture.asset(AssetsManager.logout,height: AppSize.s30,width: AppSize.s30,),
          title: Text(AppStrings.logout.tr(),style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorManager.grey1,fontSize: AppSize.s16),),
          trailing:  Icon(Icons.arrow_forward_ios,color: ColorManager.primary,),
          onTap: (){
            _logout();
          },
        ),

      ],
    );
  }

  _changeLanguage(){
    if(_appPrefs.getData(key: PREFS_KEY_LANG) == LanguageType.ARABIC.getValue()){
      _appPrefs.putData(key: PREFS_KEY_LANG, value:  LanguageType.ENGLISH.getValue());
      Phoenix.rebirth(context);
    }else {
      _appPrefs.putData(key: PREFS_KEY_LANG, value:  LanguageType.ARABIC.getValue());
      Phoenix.rebirth(context);

    }
  }

   _logout() {
    _appPrefs.removeData(key: PREFS_KEY_LOGIN);
    _localDataSource.clearCache();
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }
}
