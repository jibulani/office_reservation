import 'package:flutter/material.dart';
import 'package:office_reservation/repository/first_page_repository.dart';
import 'package:office_reservation/repository/second_page_repository.dart';
import 'package:office_reservation/ui/page/main_page.dart';

class OfficeReservationApp extends MaterialApp {
  OfficeReservationApp({Key? key})
      : super(
            key: key,
            home: MainPage(
                firstPageRepository: FirstPageRepository(),
                secondPageRepository: SecondPageRepository()
            )
  );
}
