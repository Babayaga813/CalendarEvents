import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'date_selection_state.dart';

class DateSelectionCubit extends Cubit<DateSelectionState> {
  DateSelectionCubit()
      : super(DateSelectionInitial(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.now(),
            focusedDay: DateTime.now()));

  void ChangeDate(DateTime selectedDay, DateTime focusedDay) {
    emit(UpdateDate(selectedDay: selectedDay, focusedDay: focusedDay));
  }
}
