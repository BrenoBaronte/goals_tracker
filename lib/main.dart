import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Build',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Build'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Brick> bricks = [
    Brick('English'),
    Brick('Flutter'),
    Brick('Exercises'),
    Brick('Final Project'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView(
        children: bricks.map(_createItem).toList(),
      ),
    );
  }

  Widget _createItem(Brick brick) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 10),
            Flexible(
                child: Text(
              brick.count.toString(),
              style: _textStyle,
              overflow: TextOverflow.fade,
            )),
            SizedBox(width: 20),
            Text(
              brick.title,
              style: _textStyle,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    brick.decrement();
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    brick.increment();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Brick {
  String title;
  int count = 0;
  String countUnit = 'days';

  void increment() => count++;

  void decrement() => count--;

  Brick(this.title);
}

final TextStyle _textStyle = TextStyle(fontSize: 22.0);
