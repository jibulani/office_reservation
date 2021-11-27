import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_bloc.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_event.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_state.dart';
import 'package:office_reservation/repository/model/place.dart';

class PlacePainter extends StatelessWidget {

  static const Color availablePlaceColor = Color(0xFF3E3EBA);
  static const Color selectedPlaceColor = Color(0xFF17916B);
  static const Color reservedPlaceColor = Color(0xFFAEAFB7);

  final double width;
  final List<Place> places;
  final ReservationBloc bloc;

  const PlacePainter(
      {Key? key, required this.width, required this.places, required this.bloc}
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
        builder: (BuildContext context, ReservationState state) {
            return Stack(
              children: buildPlaces(context),
            );
          }
    );
  }

  List<Widget> buildPlaces(BuildContext context) {
    List<Widget> placeWidgets = [];
    var height = MediaQuery.of(context).size.height;
    for (var element in places) {
      placeWidgets.add(
          Positioned(
              left: (MediaQuery.of(context).size.width / 2) + (width*element.xCoordinateMultiplier*(element.originalWidth/MediaQuery.of(context).size.width)),
              top: (height / 2) - (height*element.yCoordinateMultiplier),
              child: Container(
                width: MediaQuery.of(context).orientation == Orientation.portrait ?
                width*element.widthMultiplier * (MediaQuery.of(context).size.width/element.originalWidth) :
                height*element.heightMultiplier * (height/element.originalHeight),
                height: MediaQuery.of(context).orientation == Orientation.portrait ?
                height*element.heightMultiplier*(height/element.originalHeight) :
                width*element.heightMultiplier * (width/element.originalWidth),
                decoration: BoxDecoration(
                    color: element.isSelected ? selectedPlaceColor : element.isReserved ?
                    reservedPlaceColor : availablePlaceColor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: MaterialButton(
                  onPressed: () {
                    bloc.add(PlaceTapped(element.id));
                  },
                ),
              )
          )
      );
    }
    return placeWidgets;
  }
}
