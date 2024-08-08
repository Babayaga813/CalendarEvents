import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:scheduler/BOs/EventDetailBO.dart';
import 'package:scheduler/Helpers/Navigation/AppRouteConstants.dart';
import 'package:scheduler/Pages/EventDetailsScreen/EventDetailsScreen.dart';
import 'package:scheduler/Pages/EventsScreen/EventsScreen.dart';
import 'package:scheduler/Pages/SplashScreen/SplashScreen.dart';

class AppRoutes {
  GoRouter routes = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        name: AppRouteConstants.splashRoute,
        pageBuilder: (context, state) {
          return const CupertinoPage(child: SplashScreen());
        },
      ),
      GoRoute(
        path: "/calendar",
        name: AppRouteConstants.dateSelectionRoute,
        pageBuilder: (context, state) {
          return const CupertinoPage(child: EventsScreen());
        },
      ),
      GoRoute(
        path: "/event",
        name: AppRouteConstants.eventDetailsRoute,
        pageBuilder: (context, state) {
          final data = state.extra as EventDetail;
          // EventDetail detail = EventDetail(
          //     createdAt: DateTime(2023, 10, 10),
          //     title: "iure",
          //     description:
          //         "Accusantium voluptatibus minus commodi quasi. Expedita voluptate fugiat quo amet labore fugiat quia accusamus. Libero fugiat consequuntur adipisci culpa. Dolorum dignissimos nemo facilis in aperiam inventore nisi perferendis.",
          //     status: "Cancelled",
          //     startAt: DateTime(2024, 08, 22),
          //     duration: 75,
          //     id: "7e3d6ee0fdb62c2efeb85ecf",
          //     images: ["https://loremflickr/640/480/nature"]);
          return CupertinoPage(
              child: EventDetailsScreen(
            eventDetail: data,
          ));
        },
      ),
    ],
  );
}
