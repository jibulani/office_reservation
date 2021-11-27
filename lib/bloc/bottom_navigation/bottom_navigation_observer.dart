
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class BottomNavigationObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }
}