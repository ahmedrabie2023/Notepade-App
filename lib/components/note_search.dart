import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cubit_app/notes_cubit.dart';
import 'item_note.dart';

class NoteSearch extends SearchDelegate {
  List ?filterNotes;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () {
        query = "";
      },)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
    ), onPressed: () {
      close(context, null);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = NotesCubit.get(context);
          List notes = BlocProvider.of<NotesCubit>(context).notes!;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                  itemCount: cubit.notes?.length,
                  itemBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ItemNote(noteAppModel: notes[index],
                          colors: const Color(0xffFFCC80),),
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}