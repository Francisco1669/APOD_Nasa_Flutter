import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_event.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_state.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod_repository.dart';

class ApodBloc extends Bloc<TodayApodEvent, ApodTodayState> {
  final _apodRepo = ApodRepository(dio: Dio());

  ApodBloc() : super(ApodTodayInitialState()) {
    on<LoadApodEvent>(
      (event, emit) async {
        final apod = await _apodRepo.getTodayApod();
        emit(ApodTodayLoadingState());
        try {
          emit(ApodTodaySucessState(apod: apod));
        } catch (e) {
          throw e;
        }
      },
    );
    on<LoadApodByDateEvent>(
      (event, emit) async {
        final apod = await _apodRepo.getApodByDate(event.date);
        emit(ApodTodayLoadingState());
        try {
          emit(ApodTodaySucessState(apod: apod));
        } catch (e) {
          throw e;
        }
      },
    );
  }
}
