import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dayoff/app_const.dart';
import 'package:dayoff/core/widgets/snack_bar_error.dart';
import 'package:dayoff/features/notes/presentation/cubit/note_cubit.dart';
import 'package:dayoff/features/notes/presentation/widgets/no_note_widget.dart';

class NotesScreen extends StatefulWidget {
  final String uid;
  const NotesScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  GlobalKey<ScaffoldState> _scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<NoteCubit>(context).getNotes(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "MyNotes ",
      //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      //   ),
      //   actions: [
      //     LogOutIcon(),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, PageConst.addNotePage,
              arguments: widget.uid);
        },
      ),
      body: BlocConsumer<NoteCubit, NoteState>(
        listener: (context, noteState) {
          print('NOTE SCREEN');
          // if (noteState is NoteInitial) {
          //   print('NOTE INITIAL');

          //   BlocProvider.of<NoteCubit>(context).getNotes(uid: widget.uid);
          // }
          if (noteState is NoteFailure) {
            snackBarError(
                msg: "invalid email", scaffoldState: _scaffoldGlobalKey);
          }
        },
        builder: (context, noteLoadedState) {
          // print('NOTE SCREEN 2');
          // print(noteLoadedState);

          if (noteLoadedState is NoteLoaded) {
            return Column(
              children: [
                Expanded(
                  child: noteLoadedState.notes.isEmpty
                      ? NoNotesWidget()
                      : GridView.builder(
                          itemCount: noteLoadedState.notes.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1.2),
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageConst.UpdateNotePage,
                                    arguments: noteLoadedState.notes[index]);
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Delete Note"),
                                      content: Text(
                                          "are you sure you want to delete this note."),
                                      actions: [
                                        TextButton(
                                          child: Text("Delete"),
                                          onPressed: () {
                                            BlocProvider.of<NoteCubit>(context)
                                                .deleteNote(
                                                    note: noteLoadedState
                                                        .notes[index]);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        TextButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.2),
                                          blurRadius: 2,
                                          spreadRadius: 2,
                                          offset: Offset(0, 1.5))
                                    ]),
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${noteLoadedState.notes[index].note}",
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                        "${DateFormat("dd MMM yyy hh:mm a").format(noteLoadedState.notes[index].time!.toDate())}")
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
