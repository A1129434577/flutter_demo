// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Sections/CellLayout.dart';
import 'Sections/LBCodeInput/CodeInputWidgetTest.dart';
import 'Sections/LBGetCodeButton/LBGetCodeButtonTestPage.dart';
import 'Sections/TabBarTest.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: TestListView());
  }
}

class TestListView extends StatelessWidget {
  List<String> textTitleArray = [
    "CellLayoutTest",
    "CodeInputWidgetTest",
    "TabBarTest",
    "GetCodeButtonTest",
  ];
  List<Widget> pages = [
    CellLayout(),
    CodeInputWidgetPage(),
    TabBarTestPage(),
    LBGetCodeButtonTestPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Test Demo'),
      ),
      body: ListView.builder(
          itemCount: textTitleArray.length,
          itemBuilder: (context, int index) {
            return Column(
              children: [
                Container(
                  height: 70,
                  child: Center(
                      child: ListTile(
                    title: Text(
                      textTitleArray[index],
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context){
                                return pages[index];
                              })
                      );


                      // showYCAlertDialog(
                      //   context: context,
                      //   title: '提示',
                      //   message: '信息信息信息',
                      //   actions: [
                      //     YCThemeButton(
                      //       title: '确定',
                      //       titleColor: Colors.red,
                      //       border: Border.all(width: 1,color: Colors.red),
                      //       waitSeconds: 5,
                      //       style: YCThemeButtonStyle.YCBackgroundGoldenTitleBlack,
                      //       onTap: (){
                      //         print('点击了确定');
                      //       },
                      //     )
                      //   ]
                      // );
                    },
                  )),
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey,
                )
              ],
            );
          }),
    );
  }
}
