import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_bloc.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_event.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_state.dart';
import 'package:office_reservation/repository/model/location.dart';
import 'package:office_reservation/repository/reserve_location_place_repository.dart';
import 'package:office_reservation/ui/page/application_page.dart';
import 'package:office_reservation/ui/page/place_painter.dart';

class ReserveLocationPlacePage extends StatelessWidget {
  final Location location;

  final ReserveLocationPlaceRepository reserveLocationPlaceRepository;

  ReserveLocationPlacePage(
      {Key? key,
      required this.location,
      required this.reserveLocationPlaceRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = ReservationBloc(reserveLocationPlaceRepository);
    bloc.add(LoadPlaces(location.id));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ApplicationPage.themeColor,
        centerTitle: true,
        title: Text(location.name,),
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
                      margin: EdgeInsets.only(bottom: 80, top: 20),
                      child: SizedBox(
                        width:
                        MediaQuery.of(context).orientation == Orientation.portrait ?
                        MediaQuery.of(context).size.width : MediaQuery.of(context).size.height,
                        height: MediaQuery.of(context).orientation == Orientation.landscape ?
                        MediaQuery.of(context).size.height : MediaQuery.of(context).size.width,
                        child: const FittedBox(
                          child: Image(
                            image: AssetImage('graphics/default_office.png'), // TODO: get image from location
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              PlacePainter(
                places: state.places,
                bloc: bloc,
              ),
              // TODO: change button if place is selected
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.7,
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
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ]);
          }
          if (state is PageMenuDialog) {
            return Container(); // TODO
          }
          return Container();
        },
      ),
    );
  }
}
