import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scheduler/Helpers/AppConstants/AppConstants.dart';
import 'package:scheduler/Helpers/Utilities/Utilities.dart';
import '../BOs/EventDetailBO.dart';

part 'day_events_state.dart';

class DayEventsCubit extends Cubit<DayEventsState> {
  DayEventsCubit() : super(DayEventsInitial(events: AppConstants.todayEvents));

  void updateDayEvents(DateTime time) {
    var events = AppConstants.events.where((event) {
      return event.startAt.toFormattedDateString() ==
          time.toFormattedDateString();
    }).toList();
    emit(UpdateDayEvents(events: events));
  }
}
