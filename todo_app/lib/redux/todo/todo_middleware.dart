import 'package:redux/redux.dart';
import 'package:http/http.dart' as http; //httpリクエスト用
import 'dart:convert'; //httpレスポンスをJSON形式に変換用
import '../../model/todo.dart';
import './todo_action.dart';
import '../app_state.dart';
import '../bottom_navigator/navigator_action.dart';
import '../../const/todoConst.dart';

class TodoMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, next) {
    //選択されたステータスに合わせてselectTodosを更新
    if (action is SetBottomNavigatorNumAction) {
      List<TodoContent> selectTodos =
          _selectTodos(action.navigation, store.state.todoState.todos);
      store.dispatch(SetSelectTodosAction(selectTodos: selectTodos));
    }

    //現在選択中のステータスに合わせてselectTodosを更新
    if (action is RefreshSelectTodoAction) {
      List<TodoContent> selectTodos = _selectTodos(
          store.state.bottomNavigatorState.navigation,
          store.state.todoState.todos);
      store.dispatch(SetSelectTodosAction(selectTodos: selectTodos));
    }

    //登録されている全てのtodoを取得
    if (action is InitTodoAction) {
      _callApiToAllTodos(store);
    }

    //todoを新規登録
    if (action is NewTodoAction) {
      _callApiAddTodo(action, store);
    }

    //todoを更新
    if (action is UpdateTodoAction) {
      _callApiUpdateTodo(action, store);
    }

    //todoを削除
    if (action is DeleteTodoAction) {
      _callApiDeleteTodo(action, store);
    }

    next(action);
  }

  //todosから欲しいデータだけを取得
  List<TodoContent> _selectTodos(int selectNo, List<TodoContent> todos) {
    switch (selectNo) {
      case 0:
        return todos;
      case 1:
        return _toTodoContents(todos);
      case 2:
        return _doingTodoContents(todos);
      default:
        return _doneTodoContents(todos);
    }
  }

  List<TodoContent> _toTodoContents(List<TodoContent> todos) {
    return todos.where((todo) {
      return todo.isTo();
    }).toList();
  }

  List<TodoContent> _doingTodoContents(List<TodoContent> todos) {
    return todos.where((todo) {
      return todo.isDoing();
    }).toList();
  }

  List<TodoContent> _doneTodoContents(List<TodoContent> todos) {
    return todos.where((todo) {
      return todo.isDone();
    }).toList();
  }
}

//apiを呼び出しDBから取得したデータをtodosとselectTodosに入力
Future _callApiToAllTodos(Store<AppState> store) async {
  //json -> map -> list -> todos -> selectTodos
  http.Response response = await http.get(Uri.parse("$todoApiRoute/list"));

  Map mapData = json.decode(response.body);

  List listData = mapData["data"];

  List<TodoContent> todos = [];
  for (var data in listData) {
    //int型でDBに保存されているstateをTodoStatus型に変換
    TodoStatus state = IntToTodoStatus(data["state"]);
    todos.add(TodoContent(
        id: data["id"],
        title: data["title"],
        content: data["content"],
        state: state));
  }

  store.dispatch(SetTodosAction(todos: todos));
  store.dispatch(SetSelectTodosAction(selectTodos: todos));
}

//apiを呼び出してtodoを登録
Future _callApiAddTodo(action, Store<AppState> store) async {
  final response = await http.post(Uri.parse("$todoApiRoute/add"),
      body: json.encode(action.toJson()),
      headers: {"Content-Type": "application/json"});

  Map mapData = json.decode(response.body);

  int newId = mapData["data"];

  store.dispatch(SetNewIdAction(newId: newId));
}

//apiを呼び出してtodoを更新
Future _callApiUpdateTodo(action, Store<AppState> store) async {
  await http.put(Uri.parse("$todoApiRoute/update"),
      body: json.encode(action.todo.toJson()),
      headers: {"Content-Type": "application/json"});
}

//apiを呼び出してtodoを削除
Future _callApiDeleteTodo(action, Store<AppState> store) async {
  await http.delete(Uri.parse("$todoApiRoute/delete"),
      body: json.encode(action.toJson()),
      headers: {"Content-Type": "application/json"});
}
