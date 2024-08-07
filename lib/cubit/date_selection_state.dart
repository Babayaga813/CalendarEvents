part of 'date_selection_cubit.dart';

@immutable
sealed class DateSelectionState {}

final class DateSelectionInitial extends DateSelectionState {
  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;

  DateSelectionInitial(
      {required this.focusedDay,
      required this.firstDay,
      required this.lastDay});
}

final class UpdateDate extends DateSelectionState {
  final DateTime selectedDay;
  final DateTime focusedDay;

  UpdateDate({required this.selectedDay, required this.focusedDay});
}
