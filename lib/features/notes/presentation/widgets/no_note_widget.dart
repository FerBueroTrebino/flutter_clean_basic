import 'package:flutter/material.dart';

class NoNotesWidget extends StatelessWidget {
  const NoNotesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //     height: 80,
          //     child: Image.asset('assets/notebook.png')),
          SizedBox(
            height: 10,
          ),
          Text("No notes here yet"),
        ],
      ),
    );
  }
}
