import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cubit_app/notes_cubit.dart';
import '../components/item_note.dart';
import '../components/note_search.dart';
import 'add_note.dart';

class NoteHomeScreen extends StatefulWidget {
  const NoteHomeScreen({super.key});

  @override
  State<NoteHomeScreen> createState() => _NoteHomeScreenState();
}

class _NoteHomeScreenState extends State<NoteHomeScreen> {
  final _colors = [
    const Color(0xffFF5A33),
    const Color(0xffFFEC5C),
    const Color(0xffB4CF66),
    const Color(0xff44803F),
    const Color(0xff146152),
  ];
  @override
  void initState() {
    super.initState();

    NotesCubit.get(context).fetchAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NotesCubit.get(context);
          List notes = BlocProvider.of<NotesCubit>(context).notes!;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNote(),
                      ));
                }),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Row(
                    children: [
                      const Text(
                        "Notes",
                        style: TextStyle(fontSize: 28),
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white.withOpacity(0.05),
                        ),
                        child: IconButton(
                            onPressed: () {
                              showSearch(
                                  context: context, delegate: NoteSearch());
                            },
                            icon: const Icon(Icons.search)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: cubit.notes?.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ItemNote(
                          noteAppModel: notes[index],
                          colors: _colors[index % _colors.length],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
