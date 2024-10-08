part of 'events_bloc.dart';

@immutable
sealed class EventsState {}

final class EventsInitial extends EventsState {}

final class EventsFetching extends EventsState {}

final class EventsFetched extends EventsState {}

final class ErrorOnFetch extends EventsState {
  final String error;
  ErrorOnFetch({required this.error});
}
