// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../model/todo.dart';

@immutable
class TodoState {
  final int newId;
  final List<TodoContent> todos;
  final List<TodoContent> selectTodos;

  const TodoState(
      {required this.newId, required this.todos, required this.selectTodos});

  factory TodoState.initial() =>
      TodoState(newId: 0, todos: [], selectTodos: []);

  TodoState copyWith(
      {int? newId, List<TodoContent>? todos, List<TodoContent>? selectTodos}) {
    return TodoState(
        newId: newId ?? this.newId,
        todos: todos ?? this.todos,
        selectTodos: selectTodos ?? this.selectTodos);
  }
}
