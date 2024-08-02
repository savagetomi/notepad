import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notepad/NotesInput.dart';
import 'package:notepad/bottom_nav/Notes.dart';
import 'package:notepad/bottom_nav/Todos.dart';
import 'package:notepad/bottom_nav/components/Bottom_nav_bar.dart';
import 'package:notepad/todoInput.dart';

import 'models/todos.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final todoList = Todo.todos();
  int _selectedIndex = 0;
  final _addtodoitems = TextEditingController();

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _addToDoItem(String toDo) {
    setState(() {
      todoList.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todo: toDo,
      ));
    });
    _addtodoitems.clear();
  }

  void setAlert() {}

  void saveTodo() {}

  Future<String?> showAddTodoDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text('Add a To-Do Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Input field
            TextField(
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
              controller: _addtodoitems,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: 'Enter To-Do Item',
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            // Row for buttons (optional)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Set Alarms button (modify for your functionality)
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.alarm_add,
                            size: 16,
                            color: Colors.black,
                          ),
                          Text(
                            // Close dialog for now
                            'Set Alerts',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Save button
                GestureDetector(
                  onTap: () {
                    _addToDoItem(_addtodoitems.text);
                  },
                  child: Text('SAVE',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final List<Widget> _pages = [
    Notes(),
    Todos(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(
          _selectedIndex == 0 ? Icons.note : Icons.add,
          size: 25,
          color: Colors.white,
        ),
        onPressed: () {
          if (_selectedIndex == 0) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Notesinput()));
          } else {
            showAddTodoDialog(context);
          }
        },
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: MyBottomNavBar(
          onTabChange: navigateBottomBar,
        ),
      ),
    );
  }


}
