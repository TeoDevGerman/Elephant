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
    if (db.todos.isEmpty) {
      db.createInitData();
      db.saveData();
    } else {
      db.loadData();
    }
    pages = [
      HomePage(controller: controller, todos: db.todos, db: db),
      AddMemo(controller: controller, todos: db.todos, db: db),
    ];
    super.initState();
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
  @override
  Widget build(BuildContext context) {
    const color = Color.fromRGBO(50, 1, 83, 1);
    log("current page: $currentPage");
    var todos = db.todos;
    log("todos: $todos");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Memoria",
      home: Scaffold(
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
      ),
      routes: {
        '/home': (context) => HomePage(controller: controller, todos: db.todos, db: db),
        '/addMemo': (context) =>  AddMemo(
          controller: controller,
          todos: db.todos,
          db: db,
          ),
      },
    );
  }
}