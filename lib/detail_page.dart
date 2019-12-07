import 'package:flutter/material.dart';
import 'Model/data.dart';

class Detail extends StatefulWidget {
  const Detail(this.data);
  final Data data;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail data'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  widget.data.url,
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10.0),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          child: Text(widget.data.id.toString()),
                        ),
                      ),
                     const  SizedBox(
                        width: 7.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(widget.data.title),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
