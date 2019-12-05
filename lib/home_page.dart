import 'package:flutter/material.dart';
import 'package:flutter_json/Model/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 Future<List<Data>> getAllData() async{
   const String api='https://jsonplaceholder.typicode.com/photos';
   final data = await http.get(api);
   dynamic jsonData = json.decode(data.body);
   List<Data>listOf =[];
   for(dynamic i in jsonData){
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
              title: const Text('Firs Page'),
              leading: Icon(Icons.search, color: Colors.orange),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
                title: const Text('Second Page'),
                leading: Icon(Icons.add, color: Colors.red),
                onTap: () {
                  Navigator.of(context).pop();
                }),
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
              onTap: (){
                Navigator.of(context).pop();
              },

            ),
          ],
        ),
      ),
    );
  }
}
