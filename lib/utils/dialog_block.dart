// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_do/utils/my_button.dart';

class DialogBlock extends StatelessWidget {
  DialogBlock({
    super.key,
    required this.myController,
    required this.onCancel,
    required this.onSave,
  });

  final myController;
  VoidCallback onSave;
  VoidCallback onCancel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xff86A8CF),
      content: Container(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: myController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add new task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(onPressed: onCancel, text: "Cancel"),
                SizedBox(width: 10),
                MyButton(onPressed: onSave, text: "Save"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
