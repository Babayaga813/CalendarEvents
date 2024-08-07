import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/Helpers/AppConstants/AppConstants.dart';
import 'package:scheduler/Helpers/Styles/Style.dart';
import 'package:scheduler/Helpers/Utilities/utilities.dart';
import 'package:scheduler/cubit/date_selection_cubit.dart';
import 'package:scheduler/cubit/day_events_cubit.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../BOs/EventDetailBO.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final Random random = Random();
  DateTime date = DateTime.now();
  late List<EventDetail> events;

  @override
  void initState() {
    super.initState();
    events = AppConstants.events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocConsumer<DateSelectionCubit, DateSelectionState>(
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
                          color: Color(0xFF4F4F4F),
                          fontWeight: FontWeight.w500),
                      weekendStyle: TextStyle(
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.w400),
                    ),
                    calendarStyle: const CalendarStyle(
                        defaultTextStyle:
                            TextStyle(fontWeight: FontWeight.w600),
                        selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.blackColor),
                        todayDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColors.whiteColor,
                          border: Border(
                              top: BorderSide(color: CustomColors.blackColor),
                              bottom:
                                  BorderSide(color: CustomColors.blackColor),
                              left: BorderSide(color: CustomColors.blackColor),
                              right:
                                  BorderSide(color: CustomColors.blackColor)),
                        ),
                        todayTextStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CustomColors.blackColor),
                        selectedTextStyle: TextStyle(
                            color: CustomColors.whiteColor,
                            fontWeight: FontWeight.w600)),
                    headerStyle: const HeaderStyle(
                        titleTextStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        formatButtonVisible: false,
                        titleCentered: true),
                    selectedDayPredicate: (day) => isSameDay(day, date),
                    firstDay: DateTime.utc(2022, 1, 1),
                    lastDay: DateTime.utc(2024, 12, 31),
                    onDaySelected: (selectedDay, focusedDay) {
                      context
                          .read<DateSelectionCubit>()
                          .ChangeDate(selectedDay, focusedDay);
                      context
                          .read<DayEventsCubit>()
                          .updateDayEvents(selectedDay);
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<DateSelectionCubit, DateSelectionState>(
              builder: (context, state) {
                return Container(
                  color: const Color(0xffF8F8F8),
                  child: ListTile(
                    title: Text(
                      date.dateToString(),
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                child: BlocConsumer<DayEventsCubit, DayEventsState>(
                  listener: (context, state) {
                    if (state is UpdateDayEvents) {
                      events = state.events;
                      AppConstants.todayEvents = state.events;
                    }
                  },
                  builder: (context, state) {
                    return events.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: CustomColors.whiteColor,
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(0, 2),
                                          blurRadius: 4,
                                          color: Color(0xB5D2D2D2)),
                                    ],
                                  ),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // tileColor:
                                    //     getTileColor(AppConstants.events[index]),
                                    leading: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2, bottom: 2, right: 16),
                                          child: Container(
                                            width: 6,
                                            height: double.maxFinite,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: getStatusColor(
                                                    AppConstants
                                                        .events[index])),
                                          ),
                                        ),
                                        CircleAvatar(
                                          child: Image.network(
                                            "",
                                            fit: BoxFit.fill,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return CircleAvatar(
                                                child: Image.asset(
                                                  AppConstants.eventImages[
                                                      random.nextInt(
                                                          AppConstants
                                                              .eventImages
                                                              .length)],
                                                  fit: BoxFit.fill,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    title: Text(
                                      AppConstants.events[index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22),
                                    ),
                                    subtitle: Text(
                                      AppConstants.events[index].status,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    trailing: Text(
                                      AppConstants.events[index].duration
                                          .toHoursAndMinutes(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              // ListTile(
                              //   leading: CircleAvatar(
                              //     child: Image.network(
                              //       events[index].images.isNotEmpty
                              //           ? events[index].images[0]
                              //           : "",
                              //       fit: BoxFit.contain,
                              //       errorBuilder: (context, error, stackTrace) {
                              //         return CircleAvatar(
                              //           child: Image.asset(
                              //             "assets/images/event.png",
                              //             fit: BoxFit.contain,
                              //           ),
                              //         );
                              //       },
                              //     ),
                              //   ),
                              //   title: Text(events[index].title),
                              //   subtitle: Text(events[index].status),
                              // );
                            })
                        : const Center(
                            child: Text("No Events you're all caught UP :)"),
                          );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
