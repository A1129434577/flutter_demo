import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _ShareDataWidget extends InheritedWidget{
  _ShareDataWidget({
    @required this.data,
    Widget child,
  }):super (child: child);

  int data;

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static _ShareDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ShareDataWidget>();
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    // 的子widget的`state.didChangeDependencies`会被调用
    return true;
  }
}

class InheritedWidgetTestPage extends StatefulWidget {


  InheritedWidgetTestPage({Key key}) : super(key: key);

  @override
  _InheritedWidgetTestPageState createState() => _InheritedWidgetTestPageState();
}

class _InheritedWidgetTestPageState extends State<InheritedWidgetTestPage> {

  _CountText text;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text = _CountText(count: 1,);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        title: Text('InheritedWidgetTestPage'),
    ),
    body:_ShareDataWidget(
          data: text.count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text,
              Container(height: 50,),
              Container(
                width: 100,
                height: 55,
                child: ElevatedButton(
                  child: Text('增加'),
                  onPressed: (){
                    setState(() {
                      ++text.count;
                    });
                  },
                ),
              ),
            ],
          )
      )
    );
  }
}

class _CountText extends StatelessWidget {
  int count;
  _CountText({Key key,this.count:0}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      color: Colors.cyan,
      width: 100,
      height: 55,
      child: Text(
        _ShareDataWidget.of(context)?.data.toString(),
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

