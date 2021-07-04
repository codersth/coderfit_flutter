import 'dart:ffi';

import 'package:coderfit_flutter/constants/Constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home/main_home.dart';

void main() {
  runApp(MainApp());
}

/// The main component contains [BottomNavigationBar] to hold four tabs, that is, 'fuhua' as a home page,
/// 'xiushen' as a sport page, 'yangxing' as a recuperation page, and 'guizhen' as an user's information
/// page.
class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MainContentWidget(),
    );
  }
}

/// This is the content widget that the main component holds.
class MainContentWidget extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return _MainContentState();
  }
}

/// A private state class which goes with [MainContentWidget].
class _MainContentState extends State<MainContentWidget> {
  /// Indicates which tab current selected.
  int _selectedIndex = 0;

  /// Collections of the entire pages.
  static final tabPages = <Widget>[
    MainHomeWidget(),
    Text(''),
    Text(''),
    Text('')
  ];

  /// Collections of image path inside of tab.
  static const tabDefaultImages = [
    "assets/images/ic_tab_home_default.png",
    "assets/images/ic_tab_home_default.png",
    "assets/images/ic_tab_home_default.png",
    "assets/images/ic_tab_home_default.png"
  ];

  static const tabSelectedImages = [
    "assets/images/ic_tab_home_selected.png",
    "assets/images/ic_tab_home_default.png",
    "assets/images/ic_tab_home_default.png",
    "assets/images/ic_tab_home_default.png"
  ];

  @override
  Widget build(BuildContext context) {
    // Items inside of bottom navigator in which each item has bean internationalized.
    var navigatorItems = <BottomNavigationBarItem>[
      _createBottomNavigationItem(
          0, AppLocalizations.of(context)!.tabHome),
      _createBottomNavigationItem(
          1, AppLocalizations.of(context)!.tabSport),
      _createBottomNavigationItem(
          2, AppLocalizations.of(context)!.tabRecuperation),
      _createBottomNavigationItem(
          3, AppLocalizations.of(context)!.tabUser)
    ];
    return Scaffold(
        body: Center(child: tabPages[_selectedIndex]),
        bottomNavigationBar: BottomNavigationBar(
            items: navigatorItems,
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.black,
            onTap: _navigatorItemTapped));
  }

  /// Construct [BottomNavigationBarItem] with [position], and [title].
  BottomNavigationBarItem _createBottomNavigationItem(
      int position, String title) {
    return BottomNavigationBarItem(
      icon: Image.asset(_selectedIndex == position ? tabSelectedImages[position] : tabDefaultImages[position], width: Constants.tabSize, height: Constants.tabSize),
      label: title,
      backgroundColor: Colors.lightBlue
    );
  }

  /// Tap event with [BottomNavigationBar]'s item clicked.
  void _navigatorItemTapped(int index) {
    // Update the value of _selectedIndex.
    setState(() {
      _selectedIndex = index;
    });
  }
}