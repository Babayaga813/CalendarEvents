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
        _fetchDataFromLocalDB(event, emit);
      } catch (e) {
        emit(ErrorOnFetch(error: e.toString()));
      }
    });
  }

  Future<void> _fetchDataFromLocalDB(event, emit) async {
    // Emitting fetching state
    emit(EventsFetching());

    // Retrieve events from local database
    var data = await dbservice.getEvents();

    // Check if data is empty, which means a network call is needed
    if (data.statusCode == StatusCode.noContent) {
      // Fetch events from API
      var apiResponse = await service.getEventDetails();

      // Check if API response is successful
      if (apiResponse.statusCode == StatusCode.ok) {
        // Insert events into local database
        await dbservice.insertEvents(apiResponse.data!);

        emit(EventsFetched());
      } else {
        // Handle unsuccessful API response
        emit(ErrorOnFetch(
            error: "Failed to insert data into DB but API was success"));
        // emit(EventsFetchFailed(error: "API call failed"));
        return;
      }
    } else if (data.statusCode == StatusCode.ok) {
      // If data is not empty, use the local data

      AppConstants.events = data.data!;
      AppConstants.todayEvents = data.data!.where((event) {
        return event.startAt.toFormattedDateString() ==
            DateTime.now().toFormattedDateString();
      }).toList();

      emit(EventsFetched());
    } else {
      emit(ErrorOnFetch(error: data.message));
    }

    // Emitting fetched state
  }
}
