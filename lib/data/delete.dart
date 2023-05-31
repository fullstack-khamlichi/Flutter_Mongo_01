// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mongodb_1/data/MongoDBModel.dart';
import 'package:mongodb_1/data/dbHelper/mongodb.dart';

class MongoDbDelete extends StatefulWidget {
  const MongoDbDelete({super.key});

  @override
  State<MongoDbDelete> createState() => _MongoDbDeleteState();
}

class _MongoDbDeleteState extends State<MongoDbDelete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: MongoDatabase.getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  // Display data here
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return _dataCard(
                            MongoDbModel.fromJson(snapshot.data[index]));
                      });
                } else {
                  return Center(
                    child: Text("No Data Found"),
                  );
                }
              }
            }),
      ),
    );
  }

  Widget _dataCard(MongoDbModel data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text(
                    data.firstName,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _text(data.lastName),
                  SizedBox(
                    height: 10,
                  ),
                  _text(data.address),
                ],
              ),
              IconButton(
                  onPressed: () async {
                    // Printing ID on IconButton click
                    print(data.id);
                    // Calling delete() from button click and passing argument
                    await MongoDatabase.delete(data);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Record Deleted.")));
                    setState(() {});
                  },
                  icon: Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _text(String value) {
    return Text(
      value,
      style: TextStyle(fontSize: 20),
    );
  }
}
