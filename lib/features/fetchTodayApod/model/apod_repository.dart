import 'dart:async';

import 'package:dio/dio.dart';

import 'package:nasa_api/shared/consts/url_api.dart';
import 'package:nasa_api/shared/exceptions/failures.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod.dart';

abstract class IApodRepository {
  Future<ApodModel> getTodayApod();
  Future<ApodModel> getApodByDate(String date);
}

class ApodRepository implements IApodRepository {
  final Dio dio;

  ApodRepository({required this.dio});

  @override
  Future<ApodModel> getTodayApod() async {
    try {
      final response = await dio.get(ApiConsts.url);
      print(response);

      var apod = ApodModel(
        copyright: response.data['copyright'],
        date: DateTime.parse(response.data['date']),
        explanation: response.data['explanation'],
        hdurl: response.data['hdurl'],
        mediaType: response.data['media_type'],
        serviceVersion: response.data['service_version'],
        thumbnailUrl: response.data['thumbnail_url'],
        title: response.data['title'],
        url: response.data['url'],
      );

      return apod;
    } catch (e) {
      print(e.toString());
      throw ServerFailure();
    }
  }

  Future<ApodModel> getApodByDate(String date) async {
    final response = await dio.get('${ApiConsts.url}&date=$date');
    var apod = ApodModel(
      copyright: response.data['copyright'],
      date: DateTime.parse(response.data['date']),
      explanation: response.data['explanation'],
      hdurl: response.data['hdurl'],
      mediaType: response.data['media_type'],
      serviceVersion: response.data['service_version'],
      thumbnailUrl: response.data['thumbnail_url'],
      title: response.data['title'],
      url: response.data['url'],
    );

    return apod;
  }
}
