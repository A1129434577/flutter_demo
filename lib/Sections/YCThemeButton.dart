
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum YCThemeButtonStyle {
  YCBackgroundBlueTitleWhite,
  YCBackgroundOrangeTitleWhite,
  YCBackgroundClearBorderRed,
  YCBackgroundClearBorderTitleGolden,
  YCBackgroundLightGrayTitleGray,
  YCBackgroundBlackTitleGolden,
  YCBackgroundDarkGrayTitleWhite,
  YCBackgroundGoldenTitleBlack,
  YCBackgroundRedTitleWhite
}

class YCThemeButton extends StatefulWidget with ChangeNotifier {
  String title;
  double fontSize;
  FontWeight fontWeight;
  Color titleColor;
  List<Color> gradientColors;
  BoxBorder border;
  YCThemeButtonStyle style;//设置了style,titleColor、gradientColors、border将无效
  int waitSeconds;//需要等待多少秒才可以点击
  double radius;
  GestureTapCallback onTap;

  bool _enabled;

  set enabled(bool enabled) {
    _enabled = enabled;
    notifyListeners();
  }

  get enabled => _enabled;

  Timer _timer;
  int _currentSecondCount = 0;

  YCThemeButton({
    @required this.title,
    this.style,
    this.fontSize: 17,
    this.fontWeight:FontWeight.normal,
    this.titleColor:Colors.black,
    this.gradientColors,
    this.border,
    this.waitSeconds:0,
    this.radius = -1,
    this.onTap,
  }){
    _enabled = true;

    gradientColors??=[
      Colors.white.withAlpha(0),
      Colors.white.withAlpha(0)
    ];
    if(waitSeconds>0){
      _enabled = false;
      _currentSecondCount = waitSeconds;

      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _currentSecondCount -= 1;
        if (_currentSecondCount < 1) {
          _enabled = true;
          timer.cancel();
        }
        notifyListeners();
      });
    }
  }

  @override
  _YCThemeButtonState createState() => _YCThemeButtonState();
}

class _YCThemeButtonState extends State<YCThemeButton> {
  // double borderWidth = 0;
  // Color borderColor = Colors.white.withAlpha(0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget._timer?.cancel();
    widget.removeListener(() { });
  }

  @override
  Widget build(BuildContext context) {

    widget.addListener(() {
      setState(() {});
    });

    Color userTitleColor = widget.titleColor;
    List<Color> useGradientColors = widget.gradientColors;
    BoxBorder userBorder = widget.border;
    double userRadius = widget.radius;

    switch (widget.style) {
      case YCThemeButtonStyle.YCBackgroundBlueTitleWhite:
        userBorder = null;
        userTitleColor = Colors.white;
        useGradientColors = [Color(0xFF3B8BFA), Color(0xFF53C2F5)];
        break;
      case YCThemeButtonStyle.YCBackgroundOrangeTitleWhite:
        userBorder = null;
        userTitleColor = Colors.white;
        useGradientColors = [Color(0xFFFF8337), Color(0xFFFFB72D)];
        break;
      case YCThemeButtonStyle.YCBackgroundClearBorderRed:
        userBorder = Border.all(width: 1,color: Color(0xffFF0000));
        userTitleColor = Color(0xffFF0000);
        break;
      case YCThemeButtonStyle.YCBackgroundClearBorderTitleGolden:
        userBorder = Border.all(width: 1,color: Color(0xffDBAE55));
        userTitleColor = Color(0xffDBAE55);
        break;
      case YCThemeButtonStyle.YCBackgroundLightGrayTitleGray:
        userBorder = null;
        userTitleColor = Colors.grey;
        useGradientColors = [Color(0xFFEBEBEB), Color(0xFFEBEBEB)];
        break;
      case YCThemeButtonStyle.YCBackgroundBlackTitleGolden:
        userBorder = null;
        userTitleColor = Color(0xffF5D18B);
        if(userRadius==0){userRadius=6;}
        useGradientColors = [Color(0xFF161616), Color(0xFF3E3E3E)];
        break;
      case YCThemeButtonStyle.YCBackgroundDarkGrayTitleWhite:
        userBorder = null;
        userTitleColor = Colors.white;
        if(userRadius==0){userRadius=6;}
        useGradientColors = [Color(0xFF4C4C4C), Color(0xFF989898)];
        break;
      case YCThemeButtonStyle.YCBackgroundGoldenTitleBlack:
        userBorder = null;
        userTitleColor = Colors.black;
        if(userRadius==0){userRadius=6;}
        useGradientColors = [Color(0xFFFFCC00), Color(0xFFFFD200)];
        break;
      case YCThemeButtonStyle.YCBackgroundRedTitleWhite:
        userBorder = null;
        userTitleColor = Colors.white;
        useGradientColors = [Color(0xFFD6251F), Color(0xFFD6251F)];
        break;
    }

    if (widget.enabled == false) {
      useGradientColors = [Color(0xFFC9C9C9), Color(0xFFC9C9C9)];
      userBorder = null;
    }

    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        behavior:HitTestBehavior.translucent,
        child: Container(
          child: Center(
            child: Text(
              widget.title+((widget.enabled||widget._currentSecondCount<1)?'':'('+widget._currentSecondCount.toString()+')'),
              style: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.enabled ? userTitleColor : Colors.white,
                fontWeight: widget.fontWeight,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          decoration: BoxDecoration(
            border: userBorder,
            borderRadius: BorderRadius.circular(userRadius<0?constraints.minHeight/2:userRadius),
            gradient: LinearGradient(
                colors: useGradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
            ),
          ),
        ),
        onTap: widget.enabled?widget.onTap:null,
      );
    });
  }
}
