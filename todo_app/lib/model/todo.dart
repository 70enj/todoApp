import 'package:flutter/scheduler.dart';
import 'package:todoapp/const/todoConst.dart';

enum TodoStatus { to, doing, done }

TodoStatus IntToTodoStatus(int n) {
  switch (n) {
    case 0:
      return TodoStatus.to;
    case 1:
      return TodoStatus.doing;
    default:
      return TodoStatus.done;
  }
}

int TodoStatusToInt(TodoStatus state) {
  switch (state) {
    case TodoStatus.to:
      return 0;
    case TodoStatus.doing:
      return 1;
    default:
      return 2;
  }
}

class TodoContent {
  late int id;
  final String title;
  final String content;
  late TodoStatus state;

  TodoContent(
      {required this.id,
      required this.title,
      required this.content,
      TodoStatus? state}) {
    this.state = state ?? TodoStatus.to;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        "content": content,
        "state": TodoStatusToInt(state),
      };

  void setTo() {
    state = TodoStatus.to;
  }

  void setDoint() {
    state = TodoStatus.doing;
  }

  void setDone() {
    state = TodoStatus.done;
  }

  void setNextState() {
    switch (state) {
      case TodoStatus.to:
        setDoint();
        break;
      case TodoStatus.doing:
        setDone();
        break;
      case TodoStatus.done:
        break;
    }
  }

  bool isTo() {
    return state == TodoStatus.to;
  }

  bool isDoing() {
    return state == TodoStatus.doing;
  }

  bool isDone() {
    return state == TodoStatus.done;
  }

  String getStateString() {
    if (isTo()) return "To";
    if (isDoing()) return "Doing";
    return "Done";
  }

  @override
  String toString() {
    return "$title, $content, $state";
  }
}
