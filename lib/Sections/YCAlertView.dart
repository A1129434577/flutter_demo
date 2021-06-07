import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'YCThemeButton.dart';

class YCAlertView extends Dialog {
  final double viewWidth;
  final Widget icon;
  final String title;
  final Widget titleText;
  final String message;
  final Widget messageText;
  final Widget userView;
  final List<Widget> actions; //快捷可以直接快速传入YCThemeButton

  final EdgeInsets padding;
  final double spacing;

  const YCAlertView({
    Key key,
    this.viewWidth = 0,
    this.icon,
    this.title,
    this.titleText,
    this.message,
    this.messageText,
    this.userView,
    this.actions = const [],
    this.padding = const EdgeInsets.fromLTRB(15, 25, 15, 25),
    this.spacing = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    if (this.icon != null) {
      widgets.add(this.icon);
      widgets.add(Container(
        height: this.spacing,
      ));
    }
    if (this.titleText != null) {
      widgets.add(this.titleText);
      widgets.add(Container(
        height: this.spacing,
      ));
    } else if (this.title != null) {
      widgets.add(Text(
        this.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
          decoration: TextDecoration.none,
        ),
      ));
      widgets.add(Container(
        height: this.spacing,
      ));
    }
    if (this.messageText != null) {
      widgets.add(this.messageText);
      widgets.add(Container(
        height: this.spacing,
      ));
    } else if (this.message != null) {
      widgets.add(Text(this.message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: Color(0xff666666),
            decoration: TextDecoration.none,
          )));
      widgets.add(Container(
        height: this.spacing + 10,
      ));
    }
    if (this.userView != null) {
      widgets.add(this.userView);
      widgets.add(Container(
        height: this.spacing + 10,
      ));
    }
    if (this.actions.length > 0) {
      widgets.add(LayoutBuilder(builder: (context, constraints) {
        double actionWidth = (constraints.maxWidth -
                (this.actions.length - 1) * 25 -
                padding.left -
                padding.right) /
            this.actions.length;
        double maxActionWidth = (constraints.maxWidth - 25 - padding.left - padding.right) /
            2;//最大宽度限制为2分之一

        if (actionWidth < 80) {
          actionWidth = 80;
        }
        if (actionWidth > maxActionWidth) {
          actionWidth = maxActionWidth;
        }
        double actionHeight = 45;
        if (actionWidth == 80) {
          actionHeight = 40;
        }
        return Wrap(
          runSpacing: 25,
          alignment: WrapAlignment.spaceAround,
          children: this.actions.map((action) {

            GestureTapCallback actionOnTap;

            if (action is YCThemeButton) {
              action.radius = actionHeight / 2;

              if (action.onTap != null) {
                //当两个GestureDetector重叠的时候flutter貌似只响应了最上层，所以这里置空最上层的onTap
                actionOnTap = action.onTap;
                action.onTap = null;
              }
            }
            return GestureDetector(
              child: Container(
                height: actionHeight,
                width: actionWidth,
                child: action,
              ),
              onTap: () {
                if (action is YCThemeButton) {
                  if(action.enabled){
                    Navigator.of(context).pop();
                    if (actionOnTap != null) {
                      actionOnTap();
                    }
                  }
                }else {
                  Navigator.of(context).pop();
                }
              },
            );
          }).toList(),
        );
      }));
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: this.padding,
            width: this.viewWidth > 0
                ? this.viewWidth
                : constraints.maxWidth - 50 * 2,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widgets,
            ),
          )
        ],
      );
    });
  }
}

showYCAlertDialog({
  @required BuildContext context,
  double viewWidth: 0,
  Widget icon,
  String title,
  Widget titleText,
  String message,
  Widget messageText,
  Widget userView,
  List<Widget> actions = const [], //快捷可以直接快速传入YCThemeButton
  EdgeInsets padding = const EdgeInsets.fromLTRB(15, 25, 15, 25),
  double spacing = 25,
  bool barrierDismissible = false,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation)
        {
      return YCAlertView(
        viewWidth: viewWidth,
        icon: icon,
        title: title,
        titleText: titleText,
        message: message,
        messageText: messageText,
        userView: userView,
        actions: actions,
        padding: padding,
        spacing: spacing,
      );
    },
    transitionBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return ScaleTransition(scale: animation, child: child);
    },
  );
}
