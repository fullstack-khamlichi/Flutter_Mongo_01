// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

// https://www.youtube.com/watch?v=Qsdh0rFNXLg&list=PL6KvyFEnJSRYjyZi7xOh3v_pc0-Q7jmuA

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  MongoDbModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
  });

  // OnjectID : générer id au moment de la création de n'importe quel document
  ObjectId id;
  String firstName;
  String lastName;
  String address;

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
      };
}
