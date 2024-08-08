import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../BOs/EventDetailBO.dart';
import '../Helpers/AppConstants/AppConstants.dart';
import '../Helpers/Navigation/AppRouteConstants.dart';
import '../Helpers/Styles/Style.dart';
import '../Helpers/Utilities/utilities.dart';
import '../cubit/day_events_cubit.dart';

class CustomTile extends StatefulWidget {
  const CustomTile({super.key});

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  final Random random = Random();
  late List<EventDetail> events;

  @override
  void initState() {
    super.initState();
    events = AppConstants.todayEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    itemCount: events.length,
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
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                  AppRouteConstants.eventDetailsRoute,
                                  extra: events[index]);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                                        borderRadius: BorderRadius.circular(16),
                                        color: getStatusColor(
                                            AppConstants.events[index])),
                                  ),
                                ),
                                CircleAvatar(
                                  child: Image.network(
                                    events[index].images.isNotEmpty
                                        ? events[index].images[0]
                                        : "",
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return CircleAvatar(
                                        child: Image.asset(
                                          AppConstants.eventImages[
                                              random.nextInt(AppConstants
                                                  .eventImages.length)],
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              events[index].title.capitalize(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 22),
                            ),
                            subtitle: Text(
                              events[index].status,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Text(
                              events[index].duration.toHoursAndMinutes(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Image.asset(
                          "assets/images/no-events.png",
                          height: 200,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("All caught up, no events!"),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
