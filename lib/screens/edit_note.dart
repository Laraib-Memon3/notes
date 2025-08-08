import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/note_provider.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatefulWidget {
  final Note? note;

  const EditNoteScreen({super.key, this.note});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  bool _isEditing = false;
  bool _hasNote = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initVairbales();
    });
    super.initState();
  }

  initVairbales() {
    _hasNote = widget.note != null;
    _isEditing = _hasNote;
    //print
    print("Has note: $_hasNote");
    print("Is editing: $_isEditing");
    if (_hasNote && widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      setState(() {
        
      });
    } else if (widget.note == null) {
      _titleController.text = 'No Text Available';
      _contentController.text = 'No content available';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  bool _isValidInput() {
    return _titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    final canSave =
        (_isEditing && _hasNote && _isValidInput()) ||
        (!_hasNote && _isValidInput());

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/saveline.png',
              width: 23,
              height: 23,
            ),
            onPressed: canSave
                ? () {
                    try {
                      final updatedNote = Note(
                        title: _titleController.text,
                        content: _contentController.text,
                      );
                      if (!_hasNote) {
                        noteProvider.addNote(
                          updatedNote.title,
                          updatedNote.content,
                        );
                      } else {
                        noteProvider.updateNote(updatedNote);
                      }
                      Navigator.of(context).pop();
                    } catch (e) {
                      print("Save error: $e");
                    }
                  }
                : null,
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/Favourite.png',
              width: 23,
              height: 23,
            ),
            onPressed: _hasNote ? () {} : null,
          ),
          IconButton(
            icon: Image.asset('assets/images/Edit.png', width: 23, height: 23),
            onPressed: _hasNote
                ? () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  }
                : null,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextField(
              controller: _titleController,
              enabled: _isEditing && _hasNote,
              decoration: InputDecoration(
                hintText: _hasNote ? 'Title' : 'No note to edit',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextField(
              controller: _contentController,
              enabled: _isEditing && _hasNote,
              decoration: InputDecoration(
                hintText: _hasNote
                    ? 'Edit your note here...'
                    : 'No note to edit',
                hintStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: canSave
                  ? Color.fromRGBO(72, 91, 167, 1)
                  : Colors.grey,
            ),
            onPressed: canSave
                ? () {
                    try {
                      final updatedNote = Note(
                        title: _titleController.text,
                        content: _contentController.text,
                      );
                      if (!_hasNote) {
                        noteProvider.addNote(
                          updatedNote.title,
                          updatedNote.content,
                        );
                      } else {
                        //print
                        print("Updating note: ${updatedNote.title}");
                        noteProvider.updateNote(updatedNote);
                      }
                      Navigator.of(context).pop();
                    } catch (e) {
                      print("Update error: $e");
                    }
                  }
                : null,
            child: const Text(
              'Update Note',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
