import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

// import "mongo_dart.dart" for getting objectId()
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongodb_1/data/MongoDBModel.dart';
import 'package:mongodb_1/data/dbHelper/mongodb.dart';

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({super.key});

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var addressController = TextEditingController();

  // Created a variable to display insert or update
  var _checkInsertUpdate = "Insert";

  @override
  Widget build(BuildContext context) {
    // Getting arguments from previous page and store inside variable
    MongoDbModel data =
        ModalRoute.of(context)!.settings.arguments as MongoDbModel;

    // Check data is null or not, if not then will set text inside our controller
    if (data != null) {
      fnameController.text = data.firstName;
      lnameController.text = data.lastName;
      addressController.text = data.address;

      // Create a variable to display inset or update
      _checkInsertUpdate = "Update";
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                _checkInsertUpdate,
                //"Insert Data",
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: fnameController,
                decoration: const InputDecoration(labelText: "First Name"),
              ),
              TextField(
                controller: lnameController,
                decoration: const InputDecoration(labelText: "Last Name"),
              ),
              TextField(
                minLines: 3,
                maxLines: 5,
                controller: addressController,
                decoration: const InputDecoration(labelText: "Address"),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      _fakeData();
                    },
                    child: const Text('Generate Data'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_checkInsertUpdate == "Update") {
                        // Calling update function and passing the arguments
                        _updateData(data.id, fnameController.text,
                            lnameController.text, addressController.text);
                      } else {
                        _insertData(fnameController.text, lnameController.text,
                            addressController.text);
                      }
                    },
                    //child: const Text('Insert Data'),
                    child: Text(_checkInsertUpdate),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Button click function for update
  Future<void> _updateData(
      var id, String fName, String lName, String address) async {
    final updateData = MongoDbModel(
        id: id, firstName: fName, lastName: lName, address: address);
    // Calling update function from insert.dart
    await MongoDatabase.update(updateData)
        .whenComplete(() => Navigator.pop(context));
  }

  // Creating Function for button click to call insert data
  Future<void> _insertData(String fName, String lName, String address) async {
    // Storing unique id (key) inside our variable
    var _id = M.ObjectId(); // This will use for unique ID
    final data = MongoDbModel(
        id: _id, firstName: fName, lastName: lName, address: address);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Inserted ID " + _id.$oid),
      ),
    );
    _clearAll();
  }

  void _clearAll() {
    fnameController.text = "";
    lnameController.text = "";
    addressController.text = "";
  }

  void _fakeData() {
    setState(() {
      fnameController.text = faker.person.firstName();
      lnameController.text = faker.person.lastName();
      addressController.text =
          "${faker.address.streetName()} \n ${faker.address.streetAddress()}";
    });
  }
}
