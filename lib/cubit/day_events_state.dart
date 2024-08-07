part of 'day_events_cubit.dart';

@immutable
sealed class DayEventsState {}

final class DayEventsInitial extends DayEventsState {
  final List<EventDetail> events;
  DayEventsInitial({required this.events});
}

final class UpdateDayEvents extends DayEventsState {
  final List<EventDetail> events;
  UpdateDayEvents({required this.events});
}
