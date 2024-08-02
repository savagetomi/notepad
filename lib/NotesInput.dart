import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notepad/HomePage.dart';
import 'package:notepad/NoteRepository.dart';
import 'package:notepad/bottom_nav/Notes.dart';
import 'models/notess.dart';

class Notesinput extends StatefulWidget {
   Notesinput({super.key});

  @override
  State<Notesinput> createState() => _NotesinputState();
}

class _NotesinputState extends State<Notesinput> {
  final _notesController = TextEditingController();

  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Homepage()));
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Notes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                _insertNotes();
                // String title = _titleController.text;
                // String note = _notesController.text;
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Homepage()));
                setState(() {

                });
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            TextField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              controller: _titleController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Title',
                  labelStyle: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            Expanded(
              child: TextField(
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                controller: _notesController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Write your note here',
                    labelStyle: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _insertNotes()async{
    final notess = Notess(
      id: null,
      title: _titleController.text,
      categories: _notesController.text,
      createdAt : DateTime.now(),
    );
    await Noterepository.insert(notess: notess);
  }
}
