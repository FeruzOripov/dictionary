import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";

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
  List<dynamic> _definitions = [];

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

  _fetchInfo(String word) async {
    print(word);
    final appId = '1aa4061a';
    final appKey = '3b3d888192734986e2de4f5b711397df';
    final response = await http.get('https://od-api.oxforddictionaries.com/api/v2/entries/en-us/' + word.toLowerCase(), headers: {'app_id': appId, 'app_key': appKey});
    setState(() {
      if (response.statusCode == 200) {
        final results = json.decode(response.body);
        _definitions = results['results'].first['lexicalEntries'].first["entries"].first['senses'].first['definitions'];
      } else {
        _definitions = [json.decode(response.body)['error']];
      }
      Navigator.push(
          context,  MaterialPageRoute(
            builder: (context) => DefinitionPage(word: word, definitions: _definitions),
          ),
        );
    });
  }
}

class DefinitionPage extends StatelessWidget {
  List<dynamic> definitions = [];
  String word = '';
  DefinitionPage({Key key, this.definitions, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(word)),
      body: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    return Text(definitions[position]);
                  },
                  itemCount: definitions.length,
                ),
              ),
            ),
          );
  }
}