part of 'theme_bloc.dart';

@immutable
abstract class ThemeState extends Equatable {
  ThemeState({required this.IsLight});
  late final IsLight;
  @override
  List<Object> get props => [IsLight];
}

class ChangeThemeEvent extends ThemeState {
  ChangeThemeEvent({required super.IsLight});
}
