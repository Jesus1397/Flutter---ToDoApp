import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'themechange_event.dart';
part 'themechange_state.dart';

class ThemeChangeBloc extends Bloc<ThemeChangeEvent, ThemeChangeState> {
  ThemeChangeBloc()
      : super(
          ThemeChangeState(theme: ThemeData.dark()),
        );

  @override
  Stream<ThemeChangeState> mapEventToState(
    ThemeChangeEvent event,
  ) async* {
    if (event is ChangeCurrentTheme) {
      yield* _changeCurrentTheme(state);
    }
  }
}

Stream<ThemeChangeState> _changeCurrentTheme(
  ThemeChangeState state,
) async* {
  if (state.theme == ThemeData.light()) {
    yield ThemeChangeState(theme: ThemeData.dark());
  } else if (state.theme == ThemeData.dark()) {
    yield ThemeChangeState(theme: ThemeData.light());
  }
}
