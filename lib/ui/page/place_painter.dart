import 'package:flutter/material.dart';
import 'package:office_reservation/repository/model/place.dart';

class PlacePainter extends StatelessWidget {

  static const Color availablePlaceColor = Color(0xFF3E3EBA);
  static const Color selectedPlaceColor = Color(0xFF17916B);
  static const Color reservedPlaceColor = Color(0xFFAEAFB7);

  final List<Place> places;

  const PlacePainter({Key? key, required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: buildPlaces(context),
    );
  }

  List<Widget> buildPlaces(BuildContext context) {
    List<Widget> placeWidgets = [];
    for (var element in places) {
      placeWidgets.add(
          Positioned(
              left: MediaQuery.of(context).size.width / 2 + element.xCoordinate,
              top: MediaQuery.of(context).size.height / 2 - element.yCoordinate,
              child: Container(
                width: element.width,
                height: element.height,
                decoration: BoxDecoration(
                    color: element.isSelected ? selectedPlaceColor : element.isReserved ? reservedPlaceColor : availablePlaceColor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: MaterialButton(
                  onPressed: () {
                    // TODO:
                  },
                ),
              )
          )
      );
    }
    return placeWidgets;
  }
}
