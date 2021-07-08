import 'dart:async';

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


  BaiduLocation? _baiduLocation;
  StreamSubscription<Map<String, Object>>? _locationListener = null;
  LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();

  @override
  void initState() {
    // TODO: Set iOS baidu map ak.
    _locationListener =
        _locationPlugin.onResultCallback().listen((Map<String, Object> result) {
          setState(() {
            try {
              _baiduLocation = BaiduLocation.fromMap(result);
              print(_baiduLocation);
            } catch (e) {
              print(e);
            }
          });
        });
    _locationPlugin.requestPermission((granted) {
      print("granted = $granted");
      _startLocation();
    });
    super.initState();
  }

  void _setLocOption() {
    BaiduLocationAndroidOption androidOption = new BaiduLocationAndroidOption();
    androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
    androidOption.setIsNeedAltitude(true); // 设置是否需要返回海拔高度信息
    androidOption.setIsNeedAddres(true); // 设置是否需要返回地址信息
    androidOption.setIsNeedLocationPoiList(true); // 设置是否需要返回周边poi信息
    androidOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    androidOption.setIsNeedLocationDescribe(true); // 设置是否需要返回位置描述
    androidOption.setOpenGps(true); // 设置是否需要使用gps
    androidOption.setLocationMode(LocationMode.Hight_Accuracy); // 设置定位模式
    androidOption.setScanspan(0); // 设置发起定位请求时间间隔
    Map androidMap = androidOption.getMap();

    /// ios 端设置定位参数
    BaiduLocationIOSOption iosOption = new BaiduLocationIOSOption();
    iosOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    iosOption.setBMKLocationCoordinateType(
        "BMKLocationCoordinateTypeBMK09LL"); // 设置返回的位置坐标系类型
    iosOption.setActivityType("CLActivityTypeAutomotiveNavigation"); // 设置应用位置类型
    iosOption.setLocationTimeout(10); // 设置位置获取超时时间
    iosOption.setDesiredAccuracy("kCLLocationAccuracyBest"); // 设置预期精度参数
    iosOption.setReGeocodeTimeout(10); // 设置获取地址信息超时时间
    iosOption.setDistanceFilter(100); // 设置定位最小更新距离
    iosOption.setAllowsBackgroundLocationUpdates(true); // 是否允许后台定位
    iosOption.setPauseLocUpdateAutomatically(true); //  定位是否会被系统自动暂停

    Map iosMap = iosOption.getMap();

    _locationPlugin.prepareLoc(androidMap, iosMap);
  }

  void _startLocation() {
    _setLocOption();
    _locationPlugin.startLocation();
  }

  void _stopLocation() {
    _locationPlugin.stopLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _locationListener?.cancel();
    _stopLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Located city text.
        Text("${_baiduLocation?.city}"),
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
        GestureDetector(
            onTap: _notificationClicked, child: Icon(Icons.notifications))
      ],
    );
  }

  /// Go to notification list after Notification's click event.
  _notificationClicked() {
    print("_notificationClicked");
  }
}
