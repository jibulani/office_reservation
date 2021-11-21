import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_state.dart';
import 'package:office_reservation/repository/first_page_repository.dart';
import 'package:office_reservation/repository/second_page_repository.dart';
import 'package:office_reservation/ui/page/first_page.dart';
import 'package:office_reservation/ui/page/second_page.dart';

class MainPage extends StatelessWidget {
  static const Color themeColor = Color(0xFF1D1D1D);
  static const Color greyColor = Color(0xFFAEAFB7);
  final FirstPageRepository firstPageRepository;
  final SecondPageRepository secondPageRepository;
  const MainPage({Key? key, required this.firstPageRepository, required this.secondPageRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BottomNavigationBloc(firstPageRepository, secondPageRepository);
    bloc.add(PageTapped(0));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        centerTitle: true,
        title: Text('Бронирование места в офисе',),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, BottomNavigationState state) {
          if (state is PageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FirstPageLoaded) {
            return FirstPage(text: state.text,);
          }
          if (state is SecondPageLoaded) {
            return SecondPage(number: state.number,);
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
