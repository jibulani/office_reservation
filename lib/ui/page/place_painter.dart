import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_bloc.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_event.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_state.dart';
import 'package:office_reservation/repository/model/place_info.dart';

class PlacePainter extends StatelessWidget {
  static const Color availablePlaceColor = Color(0xFF3E3EBA);
  static const Color selectedPlaceColor = Color(0xFF17916B);
  static const Color reservedPlaceColor = Color(0xFFAEAFB7);

  final double width;
  final List<PlaceInfo> places;

  const PlacePainter({Key? key, required this.width, required this.places})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ReservationBloc>(context);
    return BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, ReservationState state) {
          return Stack(
            children: _buildPlaces(context, bloc),
          );
        });
  }

  List<Widget> _buildPlaces(BuildContext context, ReservationBloc bloc) {
    List<Widget> placeWidgets = [];
    var height = MediaQuery.of(context).size.height;
    for (var element in places) {
      placeWidgets.add(Positioned(
          left: _getLeftPosition(context, element),
          top: (height / 2) - (height * element.yCoordinateMultiplier),
          child: Container(
            width: _getWidth(context, element, height),
            height: _getHeight(context, element, height),
            decoration: BoxDecoration(
                color: element.isSelected
                    ? selectedPlaceColor
                    : element.isReserved
                        ? reservedPlaceColor
                        : availablePlaceColor,
                borderRadius: BorderRadius.circular(5)),
            child: MaterialButton(
              onPressed: () {
                bloc.add(PlaceTapped(element.id));
              },
            ),
          )));
    }
    return placeWidgets;
  }

  double _getLeftPosition(BuildContext context, PlaceInfo placeInfo) {
    return (MediaQuery.of(context).size.width / 2) +
        (width *
            placeInfo.xCoordinateMultiplier *
            (placeInfo.originalWidth / MediaQuery.of(context).size.width));
  }

  double _getWidth(BuildContext context, PlaceInfo placeInfo, double height) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return width *
          placeInfo.widthMultiplier *
          (MediaQuery.of(context).size.width / placeInfo.originalWidth);
    }
    return height *
        placeInfo.widthMultiplier *
        (height / placeInfo.originalHeight);
  }

  double _getHeight(BuildContext context, PlaceInfo placeInfo, double height) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return height *
          placeInfo.heightMultiplier *
          (height / placeInfo.originalHeight);
    }
    return width *
        placeInfo.heightMultiplier *
        (width / placeInfo.originalWidth);
  }
}
