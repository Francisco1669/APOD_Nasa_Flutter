// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nasa_api/features/fetchTodayApod/model/apod.dart';

abstract class ApodTodayState {
  ApodModel apod;
  ApodTodayState({
    required this.apod,
  });
}

class ApodTodayInitialState extends ApodTodayState {
  ApodTodayInitialState() : super(apod: ApodModel());
}

class ApodTodayLoadingState extends ApodTodayState {
  ApodTodayLoadingState() : super(apod: ApodModel());
}

class ApodTodaySucessState extends ApodTodayState {
  ApodTodaySucessState({required ApodModel apod}) : super(apod: apod);
}
