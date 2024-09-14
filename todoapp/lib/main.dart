import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';

import 'pages/add_memo_page.dart';
import 'pages/home_page.dart';
void main() async {
  // initialize hive
  await Hive.initFlutter(); // Initialize hive

  // Open the box
  await Hive.openBox('myBox');
  runApp(const MyApp());
  log('Hello World2');
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Memoria",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final controller = TextEditingController();

  final box = Hive.box('myBox');

  List pages = [];
  bool isDone = false;

  TodoDataBase db = TodoDataBase();

  void updateTasks() {
      setState(() {
        db.todos.add({
          "task": controller.text,
          "isDone": false,
        });
        controller.clear();
      });
      db.saveData();
    }


  @override
  void initState() {
    // only create initial Data if there never was any data else load the data
    super.initState();
    if (box.get("todos") == null) {
      db.createInitData();
      db.saveData();
    } else {
      db.loadData();
    }
    pages = [
      HomePage(controller: controller, todos: db.todos, db: db),
      AddMemo(controller: controller, todos: db.todos, db: db),
    ];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int currentPage = 0;

  void updatePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void backtoHome() {
    setState(() {
      currentPage = 0;
    });
  }
  
  final color = Color.fromRGBO(50, 1, 83, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Memoria - An Elephant Never Forgets",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
        ),
        centerTitle: true,
        backgroundColor: color,
      ),
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: color,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: currentPage,
        onTap: updatePage,
        items:
        const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add Memo",
          ),
        ],
      ),
      );
  }
}