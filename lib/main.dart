import "package:flutter/material.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello, World",
      home: MyAppHome(),
    );
  }
}

class MyAppHome extends StatefulWidget {
  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  final _searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Dictionary"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child:
              TextField(
                controller: _searchFieldController,
                decoration: InputDecoration(
                  labelText: 'Enter a word',
                ),
              ),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text('CLEAR'),
                onPressed: () {
                  _searchFieldController.clear();
                },
              ),
              RaisedButton(
                child: Text("SEARCH"),
                onPressed: () {
                  _fetchInfo(_searchFieldController.value.text);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _fetchInfo(String word) {
    print(word);

  }
}