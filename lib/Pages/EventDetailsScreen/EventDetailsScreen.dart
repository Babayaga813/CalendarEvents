import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scheduler/BOs/EventDetailBO.dart';
import 'package:scheduler/Helpers/Styles/Style.dart';
import 'package:scheduler/Helpers/Utilities/utilities.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventDetail eventDetail;
  const EventDetailsScreen({super.key, required this.eventDetail});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(Icons.chevron_left_rounded)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                  color: CustomColors.whiteColor,
                  width: double.maxFinite,
                  height: 300,
                  child: widget.eventDetail.images.isNotEmpty
                      ? Image.network(
                          widget.eventDetail.images[0],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/no-event-detail.png",
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          "assets/images/no-event-detail.png",
                          fit: BoxFit.cover,
                        )),
              Padding(
                padding: const EdgeInsets.only(
                  left: 22,
                  right: 22,
                  top: 230,
                ),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: CustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Color(0xB5C8C8C8)),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.eventDetail.title.capitalize(),
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: getTileColor(widget.eventDetail),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 16),
                                child: Text(
                                  widget.eventDetail.status,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          getStatusColor(widget.eventDetail)),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.eventDetail.startAt.dateToString(),
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_outlined,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(widget.eventDetail.duration
                                .toHoursAndMinutes()),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(widget.eventDetail.description),
          ),
          const SizedBox(
            height: 18,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              "Posted on",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(widget.eventDetail.createdAt.dateToString(),
                style: const TextStyle(fontSize: 12)),
          )
        ],
      ),
    );
  }
}
