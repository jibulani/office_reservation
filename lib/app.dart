import 'package:flutter/material.dart';
import 'package:office_reservation/repository/locations_page_repository.dart';
import 'package:office_reservation/repository/reservations_page_repository.dart';
import 'package:office_reservation/ui/page/application_page.dart';

class OfficeReservationApp extends MaterialApp {
  OfficeReservationApp({Key? key})
      : super(
            key: key,
            home: ApplicationPage(
                locationsPageRepository: LocationsPageRepository(),
                secondPageRepository: ReservationsPageRepository()
            )
  );
}
