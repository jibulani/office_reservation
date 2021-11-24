
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:office_reservation/repository/model/location.dart';
import 'package:office_reservation/repository/model/place.dart';
import 'package:office_reservation/ui/page/application_page.dart';
import 'package:office_reservation/ui/page/place_painter.dart';

class ReserveLocationPlacePage extends StatelessWidget {

  final Location location;
  final List<Place> places = [
    Place(1, 40, 240, 150, 75, true, false),
    Place(2, 40, 30, 150, 75, false, false),
    Place(3, -135, 200, 150, 75, false, true),
  ];

  ReserveLocationPlacePage({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ApplicationPage.themeColor,
        centerTitle: true,
        title: Text(location.name),
      ),
      body: Stack(
          children: [
            Positioned(
                // left: MediaQuery.of(context).size.width / 2,
                // top: MediaQuery.of(context).size.height / 2,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: const FittedBox(
                      child: Image(
                          image: AssetImage('graphics/default_office.png'),
                      ),
                    ),
                  ),
                )
            ),
            PlacePainter(places: places,)
          ]
      ), // TODO
    );
  }

}
