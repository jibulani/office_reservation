import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_bloc.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_event.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_state.dart';
import 'package:office_reservation/repository/model/location.dart';
import 'package:office_reservation/repository/model/place.dart';
import 'package:office_reservation/ui/page/application_page.dart';
import 'package:office_reservation/ui/page/place_painter.dart';

class ReserveLocationPlacePage extends StatelessWidget {
  final Location location;

  const ReserveLocationPlacePage({Key? key, required this.location,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var bloc = BlocProvider.of<ReservationBloc>(context);
    bloc.add(LoadPlaces(location.id));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ApplicationPage.themeColor,
        centerTitle: true,
        title: Text(
          location.name,
        ),
      ),
      backgroundColor: const Color(0xFFEFEFEF),
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, ReservationState state) {
          if (state is PageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PlacesLoaded) {
            return Stack(children: [
              Positioned(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 80, top: 20, left: 15, right: 15
                      ),
                      child: SizedBox(
                        width: _getWidth(context),
                        height: MediaQuery.of(context).size.height,
                        child: FittedBox(
                          child: location.imgPath == null ?
                            const Image(image: AssetImage('graphics/default_office.png')) :
                            Image(image: FileImage(File(location.imgPath!))),
                        ),
                      ),
                    ),
                  ),
              ),
              PlacePainter(
                width: _getWidth(context),
                places: state.places,
                bloc: bloc,
              ),
              _getBottomButton(context, state.places, bloc),
            ]);
          }
          return Container();
        },
      ),
    );
  }

  double _getWidth(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
  }

  Widget _getBottomButton(
      BuildContext context, List<Place> places, ReservationBloc bloc) {
    var selectedPlaces = places.where((element) => element.isSelected);
    if (selectedPlaces.isEmpty) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 50,
              child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      backgroundColor: const Color(0xFF717171)),
                  child: const Text(
                    "Укажите место на карте",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
            ),
          ),
        ),
      );
    }
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 50,
            child: OutlinedButton(
                onPressed: () {
                  bloc.add(ReservationApproved(selectedPlaces.first.id));
                  _showReservationDialog(context, bloc);
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  backgroundColor: ApplicationPage.themeColor,
                ),
                child: const Text(
                  "Подтвердить",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }

  void _showReservationDialog(BuildContext context, ReservationBloc bloc) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            title: const Text('Бронирование успешно!'),
            children: <Widget>[
              _getDialogDivider(),
              SimpleDialogOption(
                padding: const EdgeInsets.symmetric(vertical: 15),
                onPressed: () {
                  Navigator.of(context).pop();
                  bloc.add(ReloadPlaces(location.id));
                },
                child: _getDialogOptionContent('Забронировать ещё'),
              ),
              _getDialogDivider(),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  BlocProvider.of<BottomNavigationBloc>(context).add(const PageTapped(1));
                },
                child: _getDialogOptionContent('Завершить'),
              ),
            ],
          );
        });
  }

  Widget _getDialogDivider() {
    return SizedBox(
      height: 1,
      child: Center(
        child: Container(
          color: const Color(0xFFEAEAEA),
          height: 1,
        ),
      ),
    );
  }

  Widget _getDialogOptionContent(String text) {
    return Center(
        child: Text(
          text,
          style: const TextStyle(
              color: Color(0xFF3E3EBA),
              fontSize: 18
          ),
        )
    );
  }
}
