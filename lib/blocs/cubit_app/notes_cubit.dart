import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../models/note_app_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
  static NotesCubit get(context) => BlocProvider.of(context);
  List ?notes;
  addNote(NoteAppModel note)
   async {
       var myBox = Hive.box("Notes");
       await myBox.add(note);
       emit(AddNoteState());
     }
   fetchAllNotes()
   {
     var myBox = Hive.box("Notes");
      notes = myBox.values.toList();
     emit(FetchAllNotesState(notes!));
   }
}
