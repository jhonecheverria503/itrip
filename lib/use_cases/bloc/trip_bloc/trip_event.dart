part of 'trip_bloc.dart';

sealed class TripEvent extends Equatable {
  const TripEvent();

  @override
  List<Object> get props => [];
}

final class StartTripEvent extends TripEvent {
  final String name;
  final String description;
  final String personStatusValue;

  const StartTripEvent({
    required this.name,
    required this.description,
    required this.personStatusValue,
  });
}

final class UpdateTripEvent extends TripEvent {
  final double latitude;
  final double longitude;

  UpdateTripEvent({required this.latitude, required this.longitude});
}

final class LoadTripsEvent extends TripEvent {}
