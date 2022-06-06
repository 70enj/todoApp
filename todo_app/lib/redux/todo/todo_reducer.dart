import 'package:redux/redux.dart';
import '../../model/todo.dart';
import './todo_action.dart';
import './todo_state.dart';

//発行されたアクションによって振り分ける
final todoReducer = combineReducers<TodoState>([
  TypedReducer<TodoState, DeleteTodoAction>(_deleteTodoActionReducer),
  TypedReducer<TodoState, AddTodoAction>(_addTodoActionReducer),
  TypedReducer<TodoState, SetNewIdAction>(_setNewId),
  TypedReducer<TodoState, SetTodosAction>(_setTodos),
  TypedReducer<TodoState, SetSelectTodosAction>(_setSelectTodos),
]);

TodoState _deleteTodoActionReducer(TodoState state, DeleteTodoAction action) {
  List<TodoContent> todos = state.todos;
  todos = todos.where((todo) => todo.id != action.id).toList();
  return state.copyWith(todos: todos);
}

TodoState _addTodoActionReducer(TodoState state, AddTodoAction action) {
  List<TodoContent> todos = state.todos;
  todos.add(
      TodoContent(id: action.id, title: action.title, content: action.content));
  return state.copyWith(todos: todos);
}

TodoState _setNewId(TodoState state, SetNewIdAction action) {
  return state.copyWith(newId: action.newId);
}

TodoState _setTodos(TodoState state, SetTodosAction action) {
  return state.copyWith(todos: action.todos);
}

TodoState _setSelectTodos(TodoState state, SetSelectTodosAction action) {
  return state.copyWith(selectTodos: action.selectTodos);
}
