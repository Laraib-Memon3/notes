import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/screens/edit_note.dart';


class NoteCard extends StatelessWidget {
  final Note note;
  final Function(Note) onDelete;

  const NoteCard({super.key, required this.note, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {         
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditNoteScreen(note: note),
            ),
          ).then((value) {
            
          }).catchError((e) {
            print("Navigation error: $e"); 
          });
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                note.content,
                style: TextStyle(fontSize: 16),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete(note),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}