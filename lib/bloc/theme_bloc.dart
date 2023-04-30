import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool IsLight;

  ThemeBloc({this.IsLight = true}) : super(ChangeThemeEvent(IsLight: IsLight)) {
    on<ThemeEvent>((event, emit) async {
      if (event is ChangeTheme) {
        IsLight = !IsLight;

        emit(ChangeThemeEvent(IsLight: IsLight));
      }
    });
  }
}
