import 'package:bloc/bloc.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_state.dart';
import 'package:office_reservation/repository/locations_page_repository.dart';
import 'package:office_reservation/repository/model/location.dart';
import 'package:office_reservation/repository/model/reservation_info.dart';
import 'package:office_reservation/repository/reservations_page_repository.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  final LocationsPageRepository locationsPageRepository;
  final ReservationsPageRepository secondPageRepository;
  int currentIndex = 0;

  BottomNavigationBloc(this.locationsPageRepository, this.secondPageRepository)
      : super(PageLoading()) {
    on<PageTapped>((event, emit) async {
      currentIndex = event.index;
      emit(CurrentIndexChanged(currentIndex));
      emit(PageLoading());
      if (event.index == 0) {
        List<Location> data = await _getLocationsPageData();
        emit(LocationsPageLoaded(data));
      }
      if (event.index == 1) {
        List<ReservationInfo> data = await _getReservationsPageData();
        emit(ReservationsPageLoaded(data));
      }
    });
  }

  Future<List<Location>> _getLocationsPageData() async {
    await locationsPageRepository.fetchData();
    List<Location> data = locationsPageRepository.data;
    return data;
  }

  Future<List<ReservationInfo>> _getReservationsPageData() async {
    await secondPageRepository.fetchData();
    List<ReservationInfo> data = secondPageRepository.data;
    return data;
  }
}
