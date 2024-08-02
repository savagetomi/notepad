import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notepad/models/notess.dart';
import 'package:notepad/models/todos.dart';
import 'package:notepad/todoItem.dart';
import 'dart:core';

class Todos extends StatefulWidget {
  const Todos({super.key});

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  final todoList = Todo.todos();
  final _searchcontroller = TextEditingController();
  List<Todo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        actions: [
          Icon(
            Ionicons.ellipse,
            size: 12,
            color: Colors.white,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'To-dos',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 36),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Search Box
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade700),
                    color: Colors.grey.shade900,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.grey),
                            onChanged: (value) => _runFilter(value),
                            controller: _searchcontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Search Notes',
                              labelStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  children: [
                    for( Todo todo in _foundToDo.reversed )
                      Todoitem(todos: todo,
                      onDeleteItem: _deleteToDoItem,
                      onToDoChanged: _handleToDoChange,)
                
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  void _handleToDoChange (Todo todos){
    setState((){
      todos.isDone = !todos.isDone;
    });
  }
  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.todo!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

}
