part of 'themechange_bloc.dart';

class ThemeChangeState {
  final ThemeData theme;

  ThemeChangeState({this.theme});

  ThemeChangeState copyWith({
    ThemeData theme,
  }) =>
      ThemeChangeState(theme: theme ?? this.theme);
}
