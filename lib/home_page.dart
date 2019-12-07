import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_json/Model/data.dart';
import 'package:http/http.dart' as http;
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MaterialColor> _color = [
    Colors.deepOrange,
    Colors.amber,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.brown
  ];

  Future<List<Data>> getAllData() async {
    const String api = 'https://jsonplaceholder.typicode.com/photos';
    final data = await http.get(api);
    final dynamic jsonData = json.decode(data.body);
    final List<Data> listOf = [];
    for (dynamic i in jsonData) {
      final Data data = Data(i['id'], i['title'], i['url'], i['thumbnailUrl']);
      listOf.add(data);
    }
    return listOf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Json Parsing App'),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => debugPrint('Search'),
          ),
          IconButton(icon: Icon(Icons.add), onPressed: () => debugPrint('Add'))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text('CodWith Ydc'),
              accountEmail: const Text('ydc@gmail.com'),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),
            ListTile(
                title: const Text('Second Page'),
                leading: Icon(Icons.add, color: Colors.red),
                onTap: () {
                  Navigator.of(context).pop();
                }),
            ListTile(
              title: const Text('Firs Page'),
              leading: Icon(Icons.search, color: Colors.orange),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
                title: const Text('Third Page'),
                leading: Icon(Icons.title, color: Colors.purple),
                onTap: () {
                  Navigator.of(context).pop();
                }),
            ListTile(
                title: const Text('Fourth Page'),
                leading: Icon(Icons.list, color: Colors.green),
                onTap: () {
                  Navigator.of(context).pop();
                }),
            const Divider(
              height: 5.0,
            ),
            ListTile(
              title: const Text('Close'),
              leading: Icon(Icons.close, color: Colors.red),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            height: 250.0,
            child: FutureBuilder(
              future: getAllData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: const Text('Loading data...'),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final MaterialColor mColor =
                          _color[index % _color.length];
                      return Card(
                        elevation: 10.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                              snapshot.data[index].url,
                              height: 150.0,
                              width: 150.0,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 7.0),
                            Container(
                              height: 50.0,
                              margin: const EdgeInsets.all(6.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: CircleAvatar(
                                      backgroundColor: mColor,
                                      child: Text(
                                          snapshot.data[index].id.toString()),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Container(
                                    width: 80.0,
                                    child: Text(
                                      snapshot.data[index].title,
                                      maxLines: 1,
                                      style:
                                          TextStyle(color: Colors.deepOrange),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 7.0),
          Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(10.0),
            child: FutureBuilder(
              future: getAllData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: const Text('Loading data...'),
                  );
                }
                else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final MaterialColor mColor = _color[index %
                          _color.length];
                      return Card(
                        elevation: 7.0,
                        child: Container(
                          height: 80.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                  snapshot.data[index].thumbnailUrl,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  child: Text(
                                    snapshot.data[index].title,
                                    style: TextStyle(fontSize: 16.0),
                                    maxLines: 2,
                                  ),
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute<Detail>(
                                        builder: (BuildContext context) => Detail(snapshot.data[index])));
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: CircleAvatar(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        snapshot.data[index].id.toString(),
                                      ),
                                    ),
                                    backgroundColor: mColor,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
