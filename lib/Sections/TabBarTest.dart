import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabBarTestPage extends StatefulWidget {
  @override
  _TabBarTestPage createState() => _TabBarTestPage();
}

class _TabBarTestPage extends State<TabBarTestPage>
    with SingleTickerProviderStateMixin {
  TabController mController;
  List<String> tabTitleList;

  List<bool> showDots = [];

  @override
  void initState() {
    super.initState();

    tabTitleList = [
      '服务通知',
      '提现通知',
      '最新资讯',
    ];

    mController = TabController(
      length: tabTitleList.length,
      vsync: this,
    );

    tabTitleList.forEach((item) {
      if(tabTitleList.indexOf(item) == mController.index){
        showDots.add(false);
      }else {
        showDots.add(true);
      }
    });

    mController.addListener(() {
      showDots[mController.index] = false;
      setState(() {
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("消息通知"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 50.0,
            child: TabBar(
                //是否可以滚动
                controller: mController,
                labelColor: Color(0xffDBAE55),
                unselectedLabelColor: Colors.black,
                indicator: TabSizeIndicator(),
                labelStyle: TextStyle(fontSize: 18.0),
                tabs: tabTitleList.map((item) {
                  NoticeTabItem newItem = NoticeTabItem(title: item);
                  newItem.showRedDot = showDots[tabTitleList.indexOf(item)];
                  return newItem;
                }).toList()
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: mController,
              children: tabTitleList.map((item) {
                return Container(
                  color: Color(0xffF4F4F4),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(item),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

}


class NoticeTabItem extends StatelessWidget {

  String title;
  bool showRedDot;

  NoticeTabItem({this.title, this.showRedDot});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Center(
            child: Tab(
              text: this.title,
            ),
          ),
          Positioned(
              top: 13,
              left: MediaQuery.of(context).size.width / 6 + 20,
              child: Container(
                height: (this.showRedDot == true) ? 10 : 0,
                width: (this.showRedDot == true) ? 10 : 0,
                // color: Colors.red,
                decoration: new BoxDecoration(
                  //背景
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ))
        ],
      ),
    );
  }
}



class TabSizeIndicator extends Decoration {

  final double wantWidth;//传入的指示器宽度，默认20

  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const TabSizeIndicator({
    this.borderSide = const BorderSide(width: 3.0, color: Color(0xffDBAE55)),
    this.insets = EdgeInsets.zero,
    this.wantWidth = 66
  }) : assert(borderSide != null),
        assert(insets != null),
        assert(wantWidth != null);

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;//指示器高度以及颜色 ，默认高度2，颜色蓝

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the
  /// tab indicator's bounds in terms of its (centered) tab widget with
  /// [TabIndicatorSize.label], or the entire tab with [TabIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is TabSizeIndicator) {
      return TabSizeIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _MyUnderlinePainter createBoxPainter([ VoidCallback onChanged ]) {
    return _MyUnderlinePainter(this,wantWidth, onChanged);
  }
}

class _MyUnderlinePainter extends BoxPainter {
  final double wantWidth;
  _MyUnderlinePainter(this.decoration, this.wantWidth,VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  final TabSizeIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;
  EdgeInsetsGeometry get insets => decoration.insets;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);

    //希望的宽度
    // double wantWidth = 20;
    //取中间坐标
    double cw = (indicator.left + indicator.right) / 2;
    return Rect.fromLTWH(cw - wantWidth / 2,
        indicator.bottom - borderSide.width, wantWidth, borderSide.width);
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size;
    final TextDirection textDirection = configuration.textDirection;
    final Rect indicator = _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    final Paint paint = borderSide.toPaint()..strokeCap = StrokeCap.square;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}