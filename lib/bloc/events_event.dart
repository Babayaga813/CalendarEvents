part of 'events_bloc.dart';

@immutable
sealed class EventsEvent {}

final class FetchEvents extends EventsEvent {}
