import 'package:flutter/material.dart';
import 'package:notes/Widgets/note_card.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/note_provider.dart';
import 'package:notes/screens/add_note_screen.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Notes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Image.asset(
                'assets/images/Vector.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          if (noteProvider.notes.isEmpty) {
            return Center(
              child: Text(
                'No notes yet! Add one using the + button',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: noteProvider.notes.length,
            itemBuilder: (context, index) {
              return NoteCard(
                note: noteProvider.notes[index],
                onDelete: (note) {
                  noteProvider.deleteNote(note);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
        },
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 1.0,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// class NoteCard extends StatelessWidget {
//   final Note note;
//   final Function(Note) onDelete;

//   const NoteCard({required this.note, required this.onDelete, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.teal,
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         title: Text(note.title),
//         subtitle: Text(note.content),
//         trailing: IconButton(
//           icon: Icon(Icons.delete, color: Colors.red),
//           onPressed: () => onDelete(note),
//         ),
//       ),
//     );
//   } 
// }