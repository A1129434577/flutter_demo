import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LBCodeInput extends StatefulWidget {
  int length;
  TextStyle textStyle;
  Color tintColor;//光标颜色
  double spacing;
  TextField hiddenTextField;
  Decoration decoration;//每个输入框边框
  ValueChanged<String> onChanged;
  bool obscureText;

  LBCodeInput({
    @required this.length,
    this.textStyle = const TextStyle(fontSize: 20),
    this.tintColor = Colors.blue,
    this.spacing = 0.0,
    this.hiddenTextField = const TextField(),
    this.decoration,
    this.onChanged,
    this.obscureText = false,
  }): assert(length != 0);

  @override
  _LBCodeInputWidgetState createState() => _LBCodeInputWidgetState();
}

class _LBCodeInputWidgetState extends State<LBCodeInput> {
  TextEditingController _textFieldController;
  FocusNode _hiddenTextFieldFocus;

  List<int> _itemsIndex;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textFieldController = widget.hiddenTextField.controller??TextEditingController();
    _hiddenTextFieldFocus = widget.hiddenTextField.focusNode??FocusNode();
    //初始化包含显示code和spacing的index数组
    _itemsIndex = List<int>.generate(widget.length*2-1, (int index) => index);
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding widgetsBinding = WidgetsBinding.instance;
    // widgetsBinding.addPostFrameCallback((callback) {
    //   print("addPostFrameCallback be invoke");
    // });
    return Container(
      child: Stack(
        children: [
          Opacity(
            opacity: 0,
            child: TextField(
              controller: _textFieldController,
              focusNode: _hiddenTextFieldFocus,
              maxLength: widget.length,
              autofocus: true,
              obscureText: widget.obscureText,

              decoration: widget.hiddenTextField.decoration,
              keyboardType: widget.hiddenTextField.keyboardType,
              textInputAction: widget.hiddenTextField.textInputAction,
              textCapitalization: widget.hiddenTextField.textCapitalization,
              style: widget.hiddenTextField.style,
              strutStyle: widget.hiddenTextField.strutStyle,
              textAlign: widget.hiddenTextField.textAlign,
              textAlignVertical: widget.hiddenTextField.textAlignVertical,
              textDirection: widget.hiddenTextField.textDirection,
              readOnly: widget.hiddenTextField.readOnly,
              toolbarOptions: widget.hiddenTextField.toolbarOptions,
              showCursor: widget.hiddenTextField.showCursor,
              obscuringCharacter: widget.hiddenTextField.obscuringCharacter,
              autocorrect: widget.hiddenTextField.autocorrect,
              enableSuggestions: widget.hiddenTextField.enableSuggestions,
              maxLines: widget.hiddenTextField.maxLines,
              minLines: widget.hiddenTextField.minLines,
              expands: widget.hiddenTextField.expands,
              maxLengthEnforcement: widget.hiddenTextField.maxLengthEnforcement,
              onEditingComplete: widget.hiddenTextField.onEditingComplete,
              onSubmitted: widget.hiddenTextField.onSubmitted,
              onAppPrivateCommand: widget.hiddenTextField.onAppPrivateCommand,
              inputFormatters: widget.hiddenTextField.inputFormatters,
              enabled: widget.hiddenTextField.enabled,
              cursorColor: widget.hiddenTextField.cursorColor,
              cursorHeight: widget.hiddenTextField.cursorHeight,
              cursorRadius: widget.hiddenTextField.cursorRadius,
              cursorWidth: widget.hiddenTextField.cursorWidth,
              selectionHeightStyle: widget.hiddenTextField.selectionHeightStyle,
              selectionWidthStyle: widget.hiddenTextField.selectionWidthStyle,
              keyboardAppearance: widget.hiddenTextField.keyboardAppearance,
              scrollPadding: widget.hiddenTextField.scrollPadding,
              dragStartBehavior: widget.hiddenTextField.dragStartBehavior,
              enableInteractiveSelection: widget.hiddenTextField.enableInteractiveSelection,
              selectionControls: widget.hiddenTextField.selectionControls,
              onTap: widget.hiddenTextField.onTap,
              mouseCursor: widget.hiddenTextField.mouseCursor,
              buildCounter: widget.hiddenTextField.buildCounter,
              scrollController: widget.hiddenTextField.scrollController,
              scrollPhysics: widget.hiddenTextField.scrollPhysics,
              autofillHints: widget.hiddenTextField.autofillHints,
              restorationId: widget.hiddenTextField.restorationId,


              onChanged: (String text) {
                if (text.length == widget.length) {
                  _hiddenTextFieldFocus.unfocus();
                }
                setState(() {
                });

                widget.onChanged!=null?widget.onChanged(text):null;
              },
            ),
          ),
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _itemsIndex.map((index){
                int itemIndex = index~/2;
                return index%2==0?
                _LBCodeShowWidget(
                  text: (_textFieldController.text.length>itemIndex)?(widget.obscureText?'●':_textFieldController.text.substring(itemIndex,itemIndex+1)):'',
                  editing: _textFieldController.text.length==itemIndex?true:false,
                  textStyle: widget.textStyle,
                  tintColor: widget.tintColor,
                  decoration: widget.decoration,
                ):Container(width: widget.spacing,);
              }).toList(),
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(_hiddenTextFieldFocus);
            },
          ),
        ],
      ),
    );
  }
}

class _LBCodeShowWidget extends StatefulWidget {
  String text;
  bool editing;
  TextStyle textStyle;
  Color tintColor;
  Decoration decoration;

  _LBCodeShowWidget({
    this.text = '',
    this.editing = false,
    this.textStyle = const TextStyle(fontSize: 20),
    this.tintColor = Colors.blue,
    this.decoration
  }): assert(text != null);

  @override
  _LBCodeShowWidgetState createState() => _LBCodeShowWidgetState();
}

class _LBCodeShowWidgetState extends State<_LBCodeShowWidget>
    with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //将动画重置到开始前的状态
          controller.reset();
          //开始执行
          controller.forward();
        }
      });

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() => {});
      });
    //启动动画(正向执行)
    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Expanded(
      child:
      Container(
        decoration: widget.decoration,
        child: Stack(
          children: [
            Center(
                child: Text(
                  widget.text,
                  style: widget.textStyle,
                )),
            Center(
              child: Opacity(
                opacity: widget.editing==true?animation.value:0,
                child: Container(
                  color: widget.tintColor,
                  width: 2,
                  height: widget.textStyle.fontSize,
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
