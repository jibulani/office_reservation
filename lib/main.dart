import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_reservation/app.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_observer.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_bloc.dart';
import 'package:office_reservation/repository/locations_page_repository.dart';
import 'package:office_reservation/repository/reservations_page_repository.dart';
import 'package:office_reservation/repository/reserve_location_place_repository.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MultiBlocProvider(providers: [
      BlocProvider<BottomNavigationBloc>(
        create: (context) => BottomNavigationBloc(
            LocationsPageRepository(), ReservationsPageRepository()),
      ),
      BlocProvider<ReservationBloc>(
        create: (context) => ReservationBloc(ReserveLocationPlaceRepository()),
      ),
    ], child: const OfficeReservationApp())),
    blocObserver: BottomNavigationObserver(),
  );
}
