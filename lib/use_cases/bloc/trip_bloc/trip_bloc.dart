import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:itrip/data/db/db_helper.dart';
import 'package:itrip/data/db/table/trip_dao.dart';
import 'package:itrip/data/model/trip.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  List<Trip> tripList = [];
  Trip? currentTrip;
  TripBloc() : super(TripInitial()) {
    on<TripEvent>((event, emit) {});
    on<StartTripEvent>(_startTrip);
    on<LoadTripsEvent>(_loadTripsEvent);
    on<UpdateTripEvent>(_updateTrip);
  }

  Future<void> _startTrip(StartTripEvent event, Emitter<TripState> emit) async {
    emit(TripLoadingState());
    try {
      currentTrip = Trip(
        name: event.name,
        description: event.description,
        companied: event.personStatusValue,
      );
      int idResult = await TripDao.insert(await DbHelper.getDb(), currentTrip!);
      if (idResult > 0) {
        currentTrip!.id = idResult;
        emit(TripStartedState(trip: currentTrip!));
      } else {
        emit(
          TripErrorState(
            reason: "No pudo iniciarse tu paseo, intenta más tarde.",
          ),
        );
      }
    } catch (e) {
      emit(
        TripErrorState(
          reason: 'Ocurrio un error inesperado, intenta más tarde.',
        ),
      );
    }
  }

  Future<void> _updateTrip(
    UpdateTripEvent event,
    Emitter<TripState> emit,
  ) async {
    emit(TripLoadingState());
    try {
      currentTrip!.latitude = event.latitude;
      currentTrip!.longitude = event.longitude;

      int idResult = await TripDao.update(await DbHelper.getDb(), currentTrip!);
      if (idResult > 0) {
        emit(TripUpdatedState());
      } else {
        emit(
          TripErrorState(
            reason:
                "Ocurrio un error inesperado al actualizar, intenta más tarde.",
          ),
        );
      }
    } catch (e) {
      emit(
        TripErrorState(
          reason:
              "Ocurrio un error inesperado al actualizar, intenta más tarde.",
        ),
      );
    }
  }

  Future<void> _loadTripsEvent(event, Emitter<TripState> emit) async {
    emit(TripLoadingState());
    try {
      tripList = await TripDao.getAll(await DbHelper.getDb());
      tripList = tripList
          .where((t) => t.latitude != null && t.longitude != null)
          .toList();
      emit(TripListState(tripList: tripList));
    } catch (e) {
      emit(
        TripErrorState(
          reason: "Ocurrio un error inesperado al cargar los paseos",
        ),
      );
    }
  }
}
