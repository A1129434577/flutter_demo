import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'LBCodeInputWidget.dart';

class CodeInputWidgetPage extends StatelessWidget {
  const CodeInputWidgetPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CodeInputWidgetPage'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 100,left: 15,right: 15),
        child:
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              color: Colors.blue,
              height: 70,
              child: LBCodeInputWidget(
                length: 6,
                textStyle: TextStyle(fontSize: 20),
                spacing: 0,//当spacing=0的时候边框因为存在重叠问题要单独处理一哈
                // obscureText: true,
                decoration: BoxDecoration(
                  color: Colors.white,
                  //设置四周圆角 角度
                  // borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  //设置四周边框
                  border:  Border(
                      top: BorderSide(
                          width: 1, color: Colors.red
                      ),
                      left: BorderSide(
                          width: 1, color: Colors.red
                      ),
                      bottom: BorderSide(
                          width: 1, color: Colors.red
                      )
                  ),
                ),
                hiddenTextField: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    //小数
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                ),
                onChanged: (text){
                  print(text);
                },
              ),
            ),
            Container(
              width: 1,
              height: 70,
              color: Colors.red,
            )
          ],
        ),
      )
    );
  }
}

