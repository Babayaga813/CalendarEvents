import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:scheduler/Helpers/AppConstants/AppConstants.dart';
import 'package:scheduler/Helpers/ServiceResult/ServiceResult.dart';
import 'package:scheduler/Helpers/Utilities/utilities.dart';

import '../Services/EventsService/EventsService.dart';
import '../Services/LocalDatabase/LocalDatabase.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  // Dependencies
  final EventsService service = GetIt.instance<EventsService>();
  final LocalDatabase dbservice = GetIt.instance<LocalDatabase>();

  // Constructor
  EventsBloc() : super(EventsInitial()) {
    // Handling FetchEvents event
    on<FetchEvents>((event, emit) async {
      try {
        // Emitting fetching state
        emit(EventsFetching());

        // Retrieve events from local database
        var data = await dbservice.getEvents();

        // Check if data is empty, which means a network call is needed
        if (data.isEmpty) {
          // Fetch events from API
          var apiResponse = await service.getEventDetails();
          print("API call made");

          // Check if API response is successful
          if (apiResponse.statusCode == StatusCode.ok) {
            // Insert events into local database
            await dbservice.insertEvents(apiResponse.data!);
          } else {
            // Handle unsuccessful API response
            print(
                "API call failed with status code: ${apiResponse.statusCode}");
            // emit(EventsFetchFailed(error: "API call failed"));
            return;
          }
        } else {
          // If data is not empty, use the local data
          print("API call not done ");
          AppConstants.events = data;
          AppConstants.todayEvents = data.where((event) {
            return event.startAt.toFormattedDateString() ==
                DateTime.now().toFormattedDateString();
          }).toList();
        }

        // Emitting fetched state
        emit(EventsFetched());
      } catch (e) {
        // Handle any errors that occur during fetching
        print('Error fetching events: $e');
        // emit(EventsFetchFailed(error: e.toString()));
      }
    });
  }
}
