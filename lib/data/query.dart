// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mongodb_1/data/MongoDBModel.dart';
import 'package:mongodb_1/data/dbHelper/mongodb.dart';

class QueryDatabase extends StatefulWidget {
  const QueryDatabase({super.key});

  @override
  State<QueryDatabase> createState() => _QueryDatabaseState();
}

class _QueryDatabaseState extends State<QueryDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getQueryData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return Center(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return displayData(
                            MongoDbModel.fromJson(snapshot.data![index]));
                      }),
                );
              } else {
                return Center(
                  child: Text("Data Not Found"),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget displayData(MongoDbModel data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.firstName,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                data.lastName,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                data.address,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
