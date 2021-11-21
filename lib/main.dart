import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:office_reservation/app.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_observer.dart';

void main() {
  BlocOverrides.runZoned(
        () => runApp(OfficeReservationApp()),
    blocObserver: BottomNavigationObserver(),
  );
}
