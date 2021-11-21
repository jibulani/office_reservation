import 'package:bloc/bloc.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit() : super(1);

  /// Add 1 to the current state.
  void loading() => emit(0);

  /// Add 1 to the current state.
  void first() => emit(1);

  /// Subtract 1 from the current state.
  void second() => emit(2);
}