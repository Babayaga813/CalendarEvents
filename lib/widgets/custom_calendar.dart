import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/Helpers/AppConstants/AppConstants.dart';
import 'package:table_calendar/table_calendar.dart';

import '../BOs/EventDetailBO.dart';
import '../Helpers/Styles/Style.dart';
import '../cubit/date_selection_cubit.dart';
import '../cubit/day_events_cubit.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime date = DateTime.now();

  List<EventDetail> _getEventsForDay(DateTime day) {
    return AppConstants.events
        .where((event) => isSameDay(event.startAt, day))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DateSelectionCubit, DateSelectionState>(
      listener: (context, state) {
        if (state is UpdateDate) {
          date = state.selectedDay;
        }
      },
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
              color: Color(0xffF4F4F4),
              border: Border.symmetric(
                  horizontal: BorderSide(color: Color(0xffBBBBBB)))),
          child: TableCalendar(
            focusedDay: date,
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                  color: Color(0xFF4F4F4F), fontWeight: FontWeight.w500),
              weekendStyle: TextStyle(
                  color: Color(0xFF6A6A6A), fontWeight: FontWeight.w400),
            ),
            calendarStyle: const CalendarStyle(
                markerDecoration: BoxDecoration(
                    color: Color(0xffA3A3A3), shape: BoxShape.circle),
                markersAnchor: 1,
                markerSizeScale: 0.2,
                markersMaxCount: 1,
                defaultTextStyle: TextStyle(fontWeight: FontWeight.w600),
                selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle, color: CustomColors.blackColor),
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColors.whiteColor,
                  border: Border(
                      top: BorderSide(color: CustomColors.blackColor),
                      bottom: BorderSide(color: CustomColors.blackColor),
                      left: BorderSide(color: CustomColors.blackColor),
                      right: BorderSide(color: CustomColors.blackColor)),
                ),
                todayTextStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.blackColor),
                selectedTextStyle: TextStyle(
                    color: CustomColors.whiteColor,
                    fontWeight: FontWeight.w600)),
            headerStyle: const HeaderStyle(
                titleTextStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                formatButtonVisible: false,
                titleCentered: true),
            selectedDayPredicate: (day) => isSameDay(day, date),
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            onDaySelected: (selectedDay, focusedDay) {
              context
                  .read<DateSelectionCubit>()
                  .ChangeDate(selectedDay, focusedDay);
              context.read<DayEventsCubit>().updateDayEvents(selectedDay);
            },
            eventLoader: _getEventsForDay,
          ),
        );
      },
    );
  }
}
