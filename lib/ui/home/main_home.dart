
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';
/// Home page inside of [MainApp] opened at the first as the shortcut entrances after app prepared for user.
class MainHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: RefreshIndicator(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: _HeadWidget(),
          ),
        ),
        onRefresh: () async {
          print('onRefresh called');
        },
      ),
    );
  }
}

/// Head part including located city, search entrance and notification icon.
class _HeadWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HeadWidgetState();
  }
}

class _HeadWidgetState extends State<_HeadWidget> {

  final LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();

  @override
  void initState() {
    _locationPlugin.requestPermission();
    // TODO: Set iOS baidu map ak.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Located city text.
        Text("上海"),
        // Entrance of search..
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            padding: EdgeInsets.all(8),
            child: Text("搜索"),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
        ),
        // Notification's icon.
        GestureDetector(onTap: _notificationClicked, child: Icon(Icons.notifications))
      ],
    );
  }

  /// Go to notification list after Notification's click event.
  _notificationClicked() {
    print("_notificationClicked");
  }
}
