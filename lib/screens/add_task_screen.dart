import 'package:flutter/material.dart';

String? newTaskTitle;

TextEditingController textEditingController = TextEditingController();

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key, this.text, this.buttonText, this.onPressed}) : super(key: key);
  final String? text;
  final String? buttonText;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF757575),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: EdgeInsets.only(
            top: 30,
            left: 80,
            right: 80,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 30),
                ),
                TextField(
                  controller: textEditingController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(),
                  onChanged: (newText) {
                    newTaskTitle = newText;
                  },
                ),
                const  SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlueAccent),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      onPressed: () {
                        if (newTaskTitle == '' || newTaskTitle == null) {
                        } else {
                          onPressed!();
                        }

                        Navigator.pop(context);

                        newTaskTitle = '';
                      },
                      child: Text(buttonText!)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
