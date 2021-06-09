// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Sections/InheritedWidgetTestPage.dart';

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
    'InheritedWidgetTestPage'
  ];
  List<Widget> pages = [
    CellLayout(),
    CodeInputWidgetPage(),
    TabBarTestPage(),
    LBGetCodeButtonTestPage(),
    InheritedWidgetTestPage(),
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
