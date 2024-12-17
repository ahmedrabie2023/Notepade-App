import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../blocs/cubit_app/notes_cubit.dart';
import '../models/note_app_model.dart';
import '../screens/edit_note.dart';
import '../screens/note_home_screen.dart';
class ItemNote extends StatelessWidget {
  final NoteAppModel noteAppModel;
  var colors;
  ItemNote({super.key, required this.noteAppModel, required this.colors});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = NotesCubit.get(context);
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNote(
                    noteAppModel: noteAppModel,
                    title: noteAppModel.title,
                    content: noteAppModel.content,
                  ),
                ));
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: colors,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        noteAppModel.title,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 28),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(noteAppModel.content,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.44),
                                fontSize: 18)),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: IconButton(
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.question,
                              animType: AnimType.rightSlide,
                              title: noteAppModel.title,
                              desc:
                                  'Do you want delete this item ?.............',
                              btnCancelOnPress: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NoteHomeScreen(),
                                    ));
                              },
                              btnOkOnPress: () {
                                noteAppModel.delete();
                                cubit.fetchAllNotes();
                              },
                            ).show();
                          },
                          icon: const Icon(Icons.delete, size: 35),
                          color: Colors.black,
                        ),
                      ),
                      isThreeLine: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(noteAppModel.date,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.44),
                                  fontSize: 18))),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
