import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CellLayout extends StatefulWidget {
  const CellLayout({Key key}) : super(key: key);

  @override
  _CellLayoutState createState() => _CellLayoutState();
}

class _CellLayoutState extends State<CellLayout> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(pair.asPascalCase, style: _biggerFont),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text('CellLayoutTest'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(15.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd)
            return Divider(
              color: Colors.cyan,
            ); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index], i);
        });
  }

  Widget _buildRow(WordPair pair, int index) {
    print('$index');
    final bool alreadySaved = _saved.contains(pair); // 新增本行
    final int contentIndex = index ~/ 2;

    return Container(
      constraints: BoxConstraints(
        maxHeight: 700.0,
        minHeight: 50.0,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.cyan,
        ),
        title: Text(
          contentIndex.isOdd
              ? pair.asPascalCase
              : '这是一个自适应cell这是一个自适应cell这是一个自适应cell这是一个自适应cell这是一个自适应cell这是一个自适应cell',
          style: TextStyle(
              color: contentIndex.isOdd ? Colors.red : Colors.black,
              fontSize: 18.0),
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
      ),
    );
  }
}

String say(String from, String msg, [String device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
