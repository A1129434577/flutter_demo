import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LBGetCodeButton extends StatefulWidget with ChangeNotifier {
  Color backgroundColor;
  Color enabledBackgroundColor;
  Text text;
  Text enabledText;
  Decoration decoration;
  GestureTapCallback onTap;

  bool _enabled = true;
  String _enabledTitle;
  String _enabledTitleSecondFront;
  String _enabledTitleSecondBehind;
  int _secondCount;
  int _currentSecondCount;

  LBGetCodeButton(
      {this.backgroundColor = Colors.white,
      this.enabledBackgroundColor = Colors.grey,
      this.text,
      this.enabledText,
      this.decoration,
      this.onTap}):assert(text!=null,enabledText!=null){

    _enabledTitle = this.enabledText.data;
    final intRegex = RegExp(r'(\d+)', multiLine: true);
    List<String> intStringList = intRegex.allMatches(_enabledTitle).map((m) => m.group(0)).toList();
    _secondCount = int.tryParse(intStringList.join());
    _currentSecondCount = _secondCount;

    String secondCountString = _secondCount.toString();
    _enabledTitleSecondFront = _enabledTitle.substring(0,_enabledTitle.indexOf(secondCountString));
    _enabledTitleSecondBehind = _enabledTitle.substring(_enabledTitle.indexOf(secondCountString)+secondCountString.length);
  }


  set enabled(bool enabled) {
    _enabled = enabled;
    notifyListeners();
  }

  get enabled => _enabled;

  @override
  _LBGetCodeButtonState createState() => _LBGetCodeButtonState();
}

class _LBGetCodeButtonState extends State<LBGetCodeButton> {

  Timer _timer;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _timer?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    widget.addListener(() {
      setState(() {});
    });


    return GestureDetector(
      child: Container(
        decoration: widget.decoration,
        color: widget.enabled
            ? widget.backgroundColor
            : widget.enabledBackgroundColor,
        child: Center(
          child: widget.enabled ? widget.text :
          Text(
            widget._enabledTitleSecondFront+widget._currentSecondCount.toString()+widget._enabledTitleSecondBehind,
            style: widget.enabledText.style,
            strutStyle: widget.enabledText.strutStyle,
            textAlign: widget.enabledText.textAlign,
            textDirection: widget.enabledText.textDirection,
            locale: widget.enabledText.locale,
            softWrap: widget.enabledText.softWrap,
            overflow: widget.enabledText.overflow,
            textScaleFactor: widget.enabledText.textScaleFactor,
            maxLines: widget.enabledText.maxLines,
            semanticsLabel: widget.enabledText.semanticsLabel,
            textWidthBasis: widget.enabledText.textWidthBasis,
            textHeightBehavior: widget.enabledText.textHeightBehavior,
          ),
        ),
      ),
      onTap: () {
        if (widget.onTap != null && widget.enabled){
          _timer = Timer.periodic(Duration(seconds: 1), (timer) {
            widget._currentSecondCount = widget._currentSecondCount - 1;
            if (widget._currentSecondCount < 0) {
              widget._currentSecondCount = widget._secondCount;
              widget._enabled = true;
              timer.cancel();
            }
            setState(() {
            });
          });
          widget.onTap();
        }
      },
    );
  }
}
