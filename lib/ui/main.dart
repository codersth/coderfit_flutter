import 'package:coderfit_flutter/ui/fix/main_fix.dart';
import 'package:coderfit_flutter/ui/recuperation/main_recuperation.dart';
import 'package:coderfit_flutter/ui/user/main_user.dart';
import 'package:coderfit_flutter/widgets/app_bottom_navigator.dart';
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
    MainFixWidget(),
    MainRecuperationWidget(),
    MainUserWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: tabPages[_selectedIndex]),
        bottomNavigationBar: AppBottomNavigator(_selectedIndex, context, _navigatorItemTapped));
  }

  /// Tap event with [BottomNavigationBar]'s item clicked.
  void _navigatorItemTapped(int index) {
    // Update the value of _selectedIndex.
    setState(() {
      _selectedIndex = index;
    });
  }
}
