import 'package:bloc/bloc.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:office_reservation/bloc/bottom_navigation/bottom_navigation_state.dart';
import 'package:office_reservation/repository/first_page_repository.dart';
import 'package:office_reservation/repository/second_page_repository.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  final FirstPageRepository firstPageRepository;
  final SecondPageRepository secondPageRepository;
  int currentIndex = 0;

  BottomNavigationBloc(this.firstPageRepository, this.secondPageRepository)
      : super(PageLoading()) {
    on<PageTapped>(
        (event, emit) async {
          currentIndex = event.index;
          emit(CurrentIndexChanged(currentIndex));
          emit(PageLoading());
          if (event.index == 0) {
            String? data = await _getFirstPageData();
            emit(FirstPageLoaded(data ?? "default data"));
          }
          if (event.index == 1) {
            int? data = await _getSecondPageData();
            emit(SecondPageLoaded(data ?? 0));
          }
        }
    );
  }

  Future<String?> _getFirstPageData() async {
    await firstPageRepository.fetchData();
    String? data = firstPageRepository.data;
    return data;
  }

  Future<int?> _getSecondPageData() async {
    await secondPageRepository.fetchData();
    int? data = secondPageRepository.data;
    return data;
  }
}
