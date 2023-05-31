// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:mongodb_1/data/dbHelper/mongodb.dart';
import 'package:mongodb_1/data/insert.dart';

import 'MongoDBModel.dart';

class MongoDbUpdate extends StatefulWidget {
  const MongoDbUpdate({super.key});

  @override
  State<MongoDbUpdate> createState() => _MongoDbUpdateState();
}

class _MongoDbUpdateState extends State<MongoDbUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: MongoDatabase.getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  // First we will display all data
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return displayCard(
                          MongoDbModel.fromJson(snapshot.data[index]));
                    });
              } else {
                return const Center(
                  child: Text("No Data Found."),
                );
              }
            }),
      ),
    );
  }

  Widget displayCard(MongoDbModel data) {
    // Displaying all Data
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${data.id.$oid}"),
                const SizedBox(
                  height: 5,
                ),
                Text("${data.firstName}"),
                const SizedBox(
                  height: 5,
                ),
                Text("${data.lastName}"),
                const SizedBox(
                  height: 5,
                ),
                Text("${data.address}"),
              ],
            ),
            // Creating IconButton for Edit
            IconButton(
              onPressed: () {
                // On Edit navigate to insert page with passing data (Model Class) as arguments
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const MongoDbInsert();
                    },
                    settings: RouteSettings(arguments: data),
                  ),
                  // Using setState() to update list of data
                ).then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
