import 'package:flutter/material.dart';
import 'package:mongodb_1/data/dbHelper/mongodb.dart';
import 'package:mongodb_1/data/query.dart';
import 'package:mongodb_1/data/delete.dart';
import 'package:mongodb_1/data/insert.dart';
import 'package:mongodb_1/data/display.dart';
import 'package:mongodb_1/data/update.dart';
import 'package:mongodb_1/pages/facebook_page.dart';
import 'package:mongodb_1/pages/first_page.dart';
import 'package:mongodb_1/pages/profile_page.dart';
import 'package:mongodb_1/tmp/carte.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Calling database connect when app start inside main()
  await MongoDatabase.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter MongoDB Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: HomePage(),
      //home: MongoDbDisplay(),
      //home: MongoDbInsert(),
      //home: const MongoDbUpdate(),
      //home: MongoDbDelete(),
      //home: QueryDatabase(),
      home: MaCarte(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return FirstPage();
      case 1:
        return FacePage();
      case 2:
        return ProfilePage();
      default:
        return const Center(child: Text('Default value'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedDrawerIndex,
        onTap: (int index) {
          setState(() {
            _selectedDrawerIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: 'FaceBook',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
