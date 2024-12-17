import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/cubit_app/notes_cubit.dart';
import '../components/text_form_field_add_Note.dart';
import '../models/note_app_model.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  var dateFormat = DateFormat("MMM d ,yyyy  h :m").format(DateTime.now());
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<NotesCubit, NotesState>(
        builder: (BuildContext context, NotesState state) {
          var cubit = NotesCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                       SizedBox(
                          height: MediaQuery.of(context).size.height*0.06
                      ),
                      Row(
                        children: [
                          const Text(
                            "Add Note",
                            style: TextStyle(fontSize: 28),
                          ),
                          const Spacer(),
                          Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height*0.08 ,
                            width: MediaQuery.of(context).size.width*0.14 ,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white.withOpacity(0.05),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState?.save();

                                    var noteModel = NoteAppModel(
                                        title: titleController.text,
                                        content: contentController.text,
                                        date: dateFormat,
                                        color: Colors.blue.value);
                                       cubit.addNote(noteModel);
                                       cubit.fetchAllNotes();
                                    Navigator.pop(context);
                                  } else {
                                    autovalidateMode = AutovalidateMode.always;
                                  }
                                  print(titleController.text);
                                  print(contentController.text);
                                  print(dateFormat);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.check)),
                          )
                        ],
                      ),
                       SizedBox(
                        height: MediaQuery.of(context).size.height*0.04 ,
                      ),
                      TextFormFieldAddNote(
                        hintText: "Title",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        controller: titleController,
                        fun: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter The Title";
                          } else {
                            return null;
                          }
                        },
                      ),
                       SizedBox(
                        height:MediaQuery.of(context).size.height*0.02 ,
                      ),
                      TextFormFieldAddNote(
                        padding: EdgeInsets.only(
                          left: 10,
                          top: 10,
                          bottom: 200
                        ),
                        hintText: "Content",
                        controller: contentController,
                        fun: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter The Content";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, NotesState state) {},
      ),
    );
  }
}
