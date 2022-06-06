import '../../model/todo.dart';

class NewTodoAction {
  final String title;
  final String content;
  NewTodoAction({required this.title, required this.content});

  Map<String, dynamic> toJson() => {
        'title': title,
        "content": content,
        "state": 0,
      };
}

class UpdateTodoAction {
  final TodoContent todo;
  UpdateTodoAction({required this.todo});
}

class DeleteTodoAction {
  final int id;
  DeleteTodoAction({required this.id});

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}

class AddTodoAction {
  final int id;
  final String title;
  final String content;
  AddTodoAction({required this.id, required this.title, required this.content});
}

class SetNewIdAction {
  final int newId;
  SetNewIdAction({required this.newId});
}

class SetTodosAction {
  final List<TodoContent> todos;
  SetTodosAction({required this.todos});
}

class SetSelectTodosAction {
  final List<TodoContent> selectTodos;
  SetSelectTodosAction({required this.selectTodos});
}

class RefreshSelectTodoAction {}

class InitTodoAction {}
