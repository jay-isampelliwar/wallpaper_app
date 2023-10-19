import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wallpaper_app/features/home/model/pexels_data_model.dart';
import 'package:wallpaper_app/services/api.dart';

class ApiService {
  Dio? dio;
  final int _perPage = 30;
  int _pageNumber = 1;
  ApiService() {
    dio = Dio();

    dio!
      ..options.baseUrl = "https://api.pexels.com/v1/" //todo BASE URL
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      ..httpClientAdapter
      ..options.headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
      };
  }

  Future<(PixelsModel, bool)> fetchCurated() async {
    try {
      final response = await dio!.get(
        Api.endpoint[Endpoint.Curated]!,
        options: Options(
          headers: {"Authorization": Api.endpoint[Endpoint.API_KEY]},
        ),
      );

      if (response.statusCode == 200) {
        return (PixelsModel.fromJson(json.decode(response.toString())), true);
      } else {
        return (PixelsModel.fromJson(json.decode(response.toString())), false);
      }
    } catch (error) {
      print("Network error: $error");
      rethrow;
    }
  }

  Future<(PixelsModel, bool)> fetchMoreCurated() async {
    _pageNumber = _pageNumber + 1;
    try {
      final response = await dio!.get(
        "curated?page=$_pageNumber&per_page=$_perPage",
        options: Options(
          headers: {"Authorization": Api.endpoint[Endpoint.API_KEY]},
        ),
      );

      if (response.statusCode == 200) {
        return (PixelsModel.fromJson(json.decode(response.toString())), true);
      } else {
        return (PixelsModel.fromJson(json.decode(response.toString())), false);
      }
    } catch (error) {
      print("Network error: $error");
      rethrow;
    }
  }
}
