import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resource/string_manager.dart';

import '../pages/home/view/home_view.dart';
import '../pages/notification/view/notification_page.dart';
import '../pages/search/search_page.dart';
import '../pages/setting/settings_page.dart';


class MainView extends StatefulWidget{
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  List<Widget> pages=[
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingsPage()
  ];

  List<String> titles=[
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notification.tr(),
    AppStrings.settings.tr(),
  ];

  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
        automaticallyImplyLeading: false,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label:AppStrings.home.tr(),),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: AppStrings.search.tr()),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none),label: AppStrings.notification.tr()),
          BottomNavigationBarItem(icon: Icon(Icons.more_vert_outlined),label: AppStrings.settings.tr()),
        ],
        onTap: (index){
          setState(() {
             _currentIndex=index;
          });
        },
      ),
    );
  }
}