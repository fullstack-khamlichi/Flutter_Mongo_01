import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongodb_1/data/MongoDBModel.dart';
import 'package:mongodb_1/main.dart';
import 'constant.dart';

// Creating Function for button click to call insert data
class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  // Creating a fuction for fetching  data from mongoDb inside our MongoDatabase file
  static Future<List<Map<String, dynamic>>> getData() async {
    // Collection name then .find() it will get all data and .toList will convert data into list(array)
    final arrData = await userCollection.find().toList();

    // return ( List of )arrData. without converting (decodeJson)
    return arrData;
  }

  // Creating function for query usage
  //Use for Query
  static Future<List<Map<String, dynamic>>> getQueryData() async {
    // first will field name(column) second will be value. This will return same age as value
    final data =
        await userCollection.find(where.eq('firstName', 'Salah')).toList();
    return data;
  }

  // Creatinf update function inside our MongoDatabase class
  static Future<void> update(MongoDbModel data) async {
    // findOne(passing id) means it will fetch that first then it stores inside result
    var result = await userCollection.findOne({"_id": data.id});
    result['firstName'] = data.firstName;
    result['lastName'] = data.lastName;
    result['address'] = data.address;
    // save (result) will update it
    var response = await userCollection.save(result);
    inspect(response);
  }

  // Creating Function for delete inside our MongoDatabase class
  static delete(MongoDbModel user) async {
    // .remove is used for delete where() is used for condition
    await userCollection.remove(where.id(user.id));
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      // Insert Query collectionName.insertOne (N.B. Data in jsonFormat)
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong while inserting data.";
      }
      return result;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
