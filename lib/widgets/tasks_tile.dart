import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final ValueKey? key;
  final String? id;
  final bool? isChecked;
  final String? taskTitle;
  final Function(bool? checkboxState)? checkboxCallBack;
  final Function(DismissDirection? dismissDirection)? deleteTaskCallBack;

  const TaskTile(
      {this.key,
      this.id,
      this.isChecked,
      this.taskTitle,
      this.checkboxCallBack,
      this.deleteTaskCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id!),
      onDismissed: deleteTaskCallBack!,
      background: Container(
        color: Colors.green,
        child: const ListTile(
          leading: Icon(Icons.edit, color: Colors.white, size: 36.0),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const ListTile(
          trailing: Icon(Icons.delete_forever, color: Colors.black, size: 36.0),
        ),
      ),
      child: ListTile(
        key: key,
        // onLongPress: onLongPress,

        // subtitle: Text(id),
        title: Text(
          taskTitle!,
          style: TextStyle(
              decoration: isChecked!
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
          onChanged: checkboxCallBack!,
        ),
      ),
    );
  }
}
