part of 'trip_bloc.dart';

sealed class TripState extends Equatable {
  const TripState();

  @override
  List<Object> get props => [];
}

final class TripInitial extends TripState {}

final class TripLoadingState extends TripState {}

final class TripErrorState extends TripState {
  final String reason;
  const TripErrorState({required this.reason});
}

final class TripStartedState extends TripState {
  final Trip trip;
  const TripStartedState({required this.trip});
}

final class TripUpdatedState extends TripState {}

final class TripEndedState extends TripState {}

final class TripListState extends TripState {
  final List<Trip> tripList;
  const TripListState({required this.tripList});
}
