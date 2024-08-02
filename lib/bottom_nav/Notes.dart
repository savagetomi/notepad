import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/models/notess.dart';
import 'package:intl/intl.dart';

import '../NoteRepository.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final _searchcontroller = TextEditingController();
  List _notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      backgroundColor: Colors.black.withOpacity(0.8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'All Notes',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 36),
                ),
              ),
              SizedBox(height: 10,),
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
                            style: TextStyle(
                                color: Colors.grey
                            ),
                            controller: _searchcontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Search Notes',
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child:
                FutureBuilder(
                  future: Noterepository.getNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState==ConnectionState.done){
                      if (snapshot.data == null || snapshot.data!.isEmpty){
                        return const Center(
                          child: Text('Empty'),
                        );
                      }
                      _notes = snapshot.data!;
                      return ListView(
                        padding: EdgeInsets.all(15),
                        children: [
                          for(var note in _notes)
                            NoteContainer(notess: note,)
                        ],
                      );
                    }
                    // else {
                    //   return Center(
                    //     child: CircularProgressIndicator(),
                    //   );
                    // }
                    return const SizedBox();
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteContainer extends StatelessWidget {

  final Notess notess;

  const NoteContainer({
    super.key, required this.notess
  });

  @override
  Widget build(BuildContext context) {

    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormat = DateFormat('HH:mm');


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0, vertical: 15),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notess.title,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // No need to specify fontStyle if it's normal
                      ),
                    ),
                    // Combine the two Text widgets in the first Row into one for better readability
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 10,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                           DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).format(notess.createdAt),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.timer,
                          size: 10,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                           DateFormat(DateFormat.HOUR_MINUTE_SECOND).format(notess.createdAt),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.file_copy_outlined,
                          size: 12,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4), // Add some spacing between the icon and text
                        Text(
                          notess.categories, // No need to add a space in the beginning
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
