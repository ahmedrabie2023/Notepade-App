import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/cubit_app/notes_cubit.dart';
import '../components/text_form_field_add_Note.dart';
import '../models/note_app_model.dart';
class EditNote extends StatefulWidget {
  final NoteAppModel noteAppModel;
  final String title;
  final  String content;
   const EditNote({super.key, required this.noteAppModel,required this.title,required this.content});
  @override
  State<EditNote> createState() => _EditNoteState();
}
class _EditNoteState extends State<EditNote> {
  TextEditingController titleEdit = TextEditingController();
  TextEditingController contentEdit = TextEditingController();
  String ?date;
  String dateFormat = DateFormat("MMM d ,yyyy  h :m").format(DateTime.now());
  @override
  void dispose() {
    super.dispose();
    titleEdit.dispose();
    contentEdit.dispose();
  }
  @override
  void initState() {
    titleEdit.text=widget.title;
    contentEdit.text= widget.content;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<NotesCubit,NotesState>(
        listener: (BuildContext context, NotesState state) {  },
        builder: (BuildContext context, NotesState state) {
          var cubit = NotesCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     SizedBox(
                      height: MediaQuery.of(context).size.height*0.06
                    ),
                    Row(
                      children: [
                        const Text(
                          "Edit Note",
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
                          child:
                          IconButton(onPressed: () {
                            widget.noteAppModel.title =titleEdit.text ;
                            widget.noteAppModel.content =contentEdit.text;
                            widget.noteAppModel.date = dateFormat;
                            widget.noteAppModel.save();
                            cubit.fetchAllNotes();
                            Navigator.pop(context);
                            setState(() {});
                          }, icon: const Icon(Icons.check)),
                        )
                      ],
                    ),
                    Column(
                       children: [
                          SizedBox(
                        height: MediaQuery.of(context).size.height*0.04 ,
                      ),
                         TextFormFieldAddNote(
                         hintText:  widget.title,
                          onchage: (value)
                          {
                            titleEdit.text =value;
                            setState(() {});
                          },
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          )),
                          SizedBox(
                        height:MediaQuery.of(context).size.height*0.02 ,
                      ),
                         TextFormFieldAddNote(
                           hintText: widget.content,
                           padding: EdgeInsets.only(
                               left: 10,
                               top: 10,
                               bottom: 200
                           ),
                        onchage: (value)
                        {
                          contentEdit.text= value;
                          setState(() {});
                        },
                      ),
                    ],
                                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
