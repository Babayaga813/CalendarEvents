import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:scheduler/BOs/EventDetailBO.dart';
import 'package:scheduler/Helpers/Navigation/AppRouteConstants.dart';
import 'package:scheduler/Pages/ErrorScreen/ErrorScreen.dart';
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
          return CupertinoPage(
              child: EventDetailsScreen(
            eventDetail: data,
          ));
        },
      ),
      GoRoute(
        path: "/error",
        name: AppRouteConstants.errorRoute,
        pageBuilder: (context, state) {
          final data = state.extra as String;
          return CupertinoPage(
              child: ErrorScreen(
            error: data,
          ));
        },
      ),
    ],
  );
}
