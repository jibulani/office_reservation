
import 'package:bloc/bloc.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_event.dart';
import 'package:office_reservation/bloc/location_place_reservation/reservation_state.dart';
import 'package:office_reservation/repository/model/place.dart';
import 'package:office_reservation/repository/reserve_location_place_repository.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {

  final ReserveLocationPlaceRepository reserveLocationPlaceRepository;
  List<Place> _data = [];

  ReservationBloc(this.reserveLocationPlaceRepository) : super(PageLoading()) {
    on<LoadPlaces>((event, emit) async {
          emit(PageLoading());
          _data = await _getPlacesByLocation(event.locationId);
          emit(PlacesLoaded(_data));
        }
    );
    on<ReloadPlaces>((event, emit) async {
      emit(PageLoading());
      _data = await _reloadPlacesByLocation(event.locationId);
      emit(PlacesLoaded(_data));
    }
    );
    on<PlaceTapped>((event, emit) async {
      var currentPlace = _data.firstWhere((element) => element.id == event.placeId);
      if (currentPlace.isSelected) {
        emit(PageLoading());
        currentPlace.isSelected = false;
        emit(PlacesLoaded(_data));
      } else if (currentPlace.isReserved) {
        // do nothing
      } else {
        emit(PageLoading());
        var previousSelectedPlace = _data.where((element) => element.isSelected == true);
        if (previousSelectedPlace.isNotEmpty) {
          previousSelectedPlace.first.isSelected = false;
        }
        currentPlace.isSelected = true;
        emit(PlacesLoaded(_data));
      }
    });
    on<ReservationApproved>((event, emit) async {
      await _reservePlace(event.placeId);
    });
  }

  Future<List<Place>> _getPlacesByLocation(int locationId) async {
    if (_data.isEmpty) {
      await reserveLocationPlaceRepository.fetchData(locationId);
      List<Place> data = reserveLocationPlaceRepository.data;
      _data = data;
    }
    return _data;
  }

  Future<List<Place>> _reloadPlacesByLocation(int locationId) async {
    await reserveLocationPlaceRepository.fetchData(locationId);
    List<Place> data = reserveLocationPlaceRepository.data;
    return data;
  }

  Future<void> _reservePlace(int placeId) async {
    await reserveLocationPlaceRepository.reservePlace(placeId);
  }
}