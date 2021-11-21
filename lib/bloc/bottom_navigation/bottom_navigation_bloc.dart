import 'package:bloc/bloc.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_state.dart';
import 'package:office_reservation/repository/locations_page_repository.dart';
import 'package:office_reservation/repository/model/location.dart';
import 'package:office_reservation/repository/second_page_repository.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  final LocationsPageRepository locationsPageRepository;
  final SecondPageRepository secondPageRepository;
  int currentIndex = 0;

  BottomNavigationBloc(this.locationsPageRepository, this.secondPageRepository)
      : super(PageLoading()) {
    on<PageTapped>(
        (event, emit) async {
          currentIndex = event.index;
          emit(CurrentIndexChanged(currentIndex));
          emit(PageLoading());
          if (event.index == 0) {
            List<Location>? data = await _getFirstPageData();
            emit(LocationsPageLoaded(data ?? []));
          }
          if (event.index == 1) {
            int? data = await _getSecondPageData();
            emit(SecondPageLoaded(data ?? 0));
          }
        }
    );
  }

  Future<List<Location>?> _getFirstPageData() async {
    await locationsPageRepository.fetchData();
    List<Location>? data = locationsPageRepository.data;
    return data;
  }

  Future<int?> _getSecondPageData() async {
    await secondPageRepository.fetchData();
    int? data = secondPageRepository.data;
    return data;
  }
}
