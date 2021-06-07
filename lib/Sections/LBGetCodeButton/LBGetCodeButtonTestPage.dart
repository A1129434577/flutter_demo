
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LBGetCodeButton.dart';

class LBGetCodeButtonTestPage extends StatelessWidget {
  const LBGetCodeButtonTestPage({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    LBGetCodeButton getCodeButton = LBGetCodeButton(
      backgroundColor: Colors.blue,
      enabledBackgroundColor: Colors.grey,
      text: Text('获取验证码', style: TextStyle(color: Colors.white)),
      enabledText: Text('60s后重新获取', style: TextStyle(color: Colors.white)),
    );
    getCodeButton.onTap = () {
      //进行网络请求getCode过后
      getCodeButton.enabled = false;


    };

    return Scaffold(
      appBar: AppBar(
        title: Text('LBGetCodeButtonTestPage'),
      ),
      body: Container(
        child: Center(
          child: Container(
            // color: Colors.cyan,
            height: 60,
            width: 150,
            child: getCodeButton,
          ),
        ),
      ),
    );
  }
}
