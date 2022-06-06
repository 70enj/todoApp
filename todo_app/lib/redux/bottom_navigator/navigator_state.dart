import 'package:flutter/material.dart';

@immutable
class BottomNavigatorState {
  final int navigation;

  const BottomNavigatorState({required this.navigation});

  factory BottomNavigatorState.initial() =>
      const BottomNavigatorState(navigation: 0);

  BottomNavigatorState copyWith({int? navigation}) {
    return BottomNavigatorState(navigation: navigation ?? this.navigation);
  }
}
