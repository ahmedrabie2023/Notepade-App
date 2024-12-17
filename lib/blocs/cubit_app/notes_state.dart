part of 'notes_cubit.dart';

@immutable
sealed class NotesState {}
final class NotesInitial extends NotesState {}
final class AddNoteState extends NotesState{}
final class FetchAllNotesState extends NotesState{
 final List noteFetch;
 FetchAllNotesState(this.noteFetch);
}