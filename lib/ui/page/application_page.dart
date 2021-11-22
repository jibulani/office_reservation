import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_state.dart';
import 'package:office_reservation/repository/locations_page_repository.dart';
import 'package:office_reservation/repository/reservations_page_repository.dart';
import 'package:office_reservation/ui/page/locations_page.dart';
import 'package:office_reservation/ui/page/reservations_page.dart';

class ApplicationPage extends StatelessWidget {
  static const Color themeColor = Color(0xFF1D1D1D);
  static const Color greyColor = Color(0xFFAEAFB7);
  final LocationsPageRepository locationsPageRepository;
  final ReservationsPageRepository secondPageRepository;
  const ApplicationPage({Key? key, required this.locationsPageRepository, required this.secondPageRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BottomNavigationBloc(locationsPageRepository, secondPageRepository);
    bloc.add(PageTapped(0));
    return Scaffold(
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, BottomNavigationState state) {
          if (state is PageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LocationsPageLoaded) {
            return LocationsPage(locations: state.locations,);
          }
          if (state is ReservationsPageLoaded) {
            return ReservationsPage(reservations: state.reservations,);
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, BottomNavigationState state) {
          return BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedIconTheme: const IconThemeData(color: themeColor),
            unselectedIconTheme: const IconThemeData(color: greyColor),
            currentIndex: bloc.currentIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time_outlined,),
                label: '',
              ),
            ],
            onTap: (index) {
              bloc.add(PageTapped(index));
            },
          );
        },
      )
    );
  }
}
