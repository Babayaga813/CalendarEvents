import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/BOs/EventDetailBO.dart';
import 'package:scheduler/Helpers/AppConstants/AppConstants.dart';
import 'package:scheduler/Helpers/Utilities/Utilities.dart';
import '../../Helpers/ServiceResult/ServiceResult.dart';

class EventsService {
  final _dio = Dio();

  Future<ServiceResult<List<EventDetail>>> getEventDetails() async {
    try {
      List<EventDetail> data = [];
      _dio.options.headers["Authorization"] =
          "Bearer 2f68dbbf-519d-4f01-9636-e2421b68f379";
      Response response = await _dio
          .get("https://mock.apidog.com/m1/561191-524377-default/Event");

      if (response.statusCode == 200) {
        var jsonDecodedData = jsonDecode(response.data);

        for (var element in jsonDecodedData["data"]) {
          var event = EventDetail.fromJson(element);
          data.add(event);
        }

        AppConstants.events = data;

        AppConstants.todayEvents = data.where((data) {
          return data.startAt.toFormattedDateString() ==
              DateTime.now().toFormattedDateString();
        }).toList();

        return ServiceResult(
            statusCode: StatusCode.ok, data: data, message: "message");
      } else {
        return ServiceResult(
            statusCode: StatusCode.badRequest,
            data: null,
            message: "An Unknown Error Occured Please try again :(");
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return ServiceResult(
          statusCode: StatusCode.accepted, data: null, message: "message");
    }
  }
}
