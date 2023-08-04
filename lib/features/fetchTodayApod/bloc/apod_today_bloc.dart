import 'dart:async';

import 'package:dio/dio.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_event.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_state.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod_repository.dart';

class ApodBloc {
  final _apodRepo = ApodRepository(dio: Dio());

  final StreamController<TodayApodEvent> _inputClientController =
      StreamController<TodayApodEvent>();

  final StreamController<ApodTodayState> _outputClientController =
      StreamController<ApodTodayState>();

  Sink<TodayApodEvent> get input => _inputClientController.sink;
  Stream<ApodTodayState> get output => _outputClientController.stream;

  ApodBloc() {
    _inputClientController.stream.listen(_mapEventToState);
  }

  _mapEventToState(TodayApodEvent event) async {
    ApodModel apod = ApodModel();
    if (event is LoadApodEvent) {
      apod = await _apodRepo.getTodayApod();
    } else if (event is LoadApodByDateEvent) {
      apod = await _apodRepo.getApodByDate(event.date);
    }
    _outputClientController.add(ApodTodaySucessState(apod: apod));
  }
}
