// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mongodb_1/data/MongoDBModel.dart';
import 'package:mongodb_1/data/dbHelper/mongodb.dart';

class MongoDbDisplay extends StatefulWidget {
  const MongoDbDisplay({super.key});

  @override
  State<MongoDbDisplay> createState() => _MongoDbDisplayState();
}

class _MongoDbDisplayState extends State<MongoDbDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          // Use FutureBuilder for fetching out Data
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            // Calling getData() from FutureBuilder
            future: MongoDatabase.getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                // Getting total length of Data
                var totalData = snapshot.data.length;
                print("Total Data" + totalData.toString());
                // Creating ListView to print each data
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      // Callung function passing data Converting (from Json) data into our Model class
                      return displayCard(
                          MongoDbModel.fromJson(snapshot.data[index]));
                    });
              } else {
                return Center(
                  child: Text("No Data available. "),
                );
              }
            }),
      )),
    );
  }

  // Creating function with Parameter (our ModelClass for Card which return Widget)
  Widget displayCard(MongoDbModel data) {
    // Displaying all Data
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${data.id.$oid}"),
            SizedBox(
              height: 5,
            ),
            Text("${data.firstName}"),
            SizedBox(
              height: 5,
            ),
            Text("${data.lastName}"),
            SizedBox(
              height: 5,
            ),
            Text("${data.address}"),
          ],
        ),
      ),
    );
  }
}
