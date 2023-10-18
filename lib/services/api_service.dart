import 'dart:developer';

import 'package:dio/dio.dart';

class ApiService {
  Dio? dio;

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

  Future<void> check(int pageNumber) async {
    try {
      final response = await dio!.get("curated?page=1&per_page=10",
          options: Options(headers: {
            "Authorization":
                "1EYoMYDTgro4ri2dmtlginRU6cjNnwxAhA1HND7DCQ9918EgF8q0Vzoo"
          }));

      if (response.statusCode == 200) {
        log(response.toString());
      }
    } catch (error) {
      print("Network error: $error");
    }
  }
}
