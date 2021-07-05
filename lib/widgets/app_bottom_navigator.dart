import 'package:coderfit_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Customized Navigator extends [BottomNavigationBar] to clear the structure of main application.
class AppBottomNavigator extends BottomNavigationBar {

  /// Collections of image path inside of tab, for each item in array, first value expresses
  /// default image, and the second value means image tab selected.
  static const tabImages = [
    ["assets/images/ic_tab_home_default.png", "assets/images/ic_tab_home_selected.png"],
    ["assets/images/ic_tab_fix_default.png", "assets/images/ic_tab_fix_selected.png"],
    ["assets/images/ic_tab_recuperation_default.png", "assets/images/ic_tab_recuperation_selected.png"],
    ["assets/images/ic_tab_user_default.png", "assets/images/ic_tab_user_selected.png"]
  ];

  /// Construct [BottomNavigationBarItem] with [position], and [title].
  static BottomNavigationBarItem _createBottomNavigationItem(
      int position, int currentPosition, String title) {
    return BottomNavigationBarItem(
        icon: Image.asset(
            currentPosition == position
                ? tabImages[position][1]
                : tabImages[position][0],
            width: Constants.tabSize,
            height: Constants.tabSize),
        label: title,
        backgroundColor: Colors.black45);
  }

  /// Construct with current position [currentPosition] and [context], optional [callback] for
  /// listening the [onTap] event.
  AppBottomNavigator(int currentPosition, BuildContext context, ValueChanged<int>? callback)
      : super(
            // With title internalization.
            items: [
              _createBottomNavigationItem(
                  0, currentPosition, AppLocalizations.of(context)!.tabHome),
              _createBottomNavigationItem(
                  1, currentPosition, AppLocalizations.of(context)!.tabFix),
              _createBottomNavigationItem(
                  2, currentPosition, AppLocalizations.of(context)!.tabRecuperation),
              _createBottomNavigationItem(
                  3, currentPosition, AppLocalizations.of(context)!.tabUser)
            ],
            currentIndex: currentPosition,
            onTap: callback);
}
