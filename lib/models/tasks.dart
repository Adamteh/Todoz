import 'dart:convert';


Task taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Task.fromMap(jsonData);
}

String taskToJson(Task data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Task {
  Task({this.id, this.name, this.isDone = false});
  final int? id;
  final String? name;
  bool? isDone;

  void toggleDone() {
    isDone = !isDone!;
  }

  factory Task.fromMap(Map<String, dynamic> json) =>  Task(
        id: json["id"],
        name: json["name"],
        isDone: json["isDone"] == 0,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "isDone": isDone,
      };
}
