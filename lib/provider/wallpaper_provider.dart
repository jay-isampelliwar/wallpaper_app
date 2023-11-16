import 'package:flutter/material.dart';
import 'package:wallpaper_app/services/api_service.dart';

import '../features/home/model/pexels_data_model.dart';

class WallpaperProvider with ChangeNotifier {
  ApiService apiService = ApiService();

  bool _loading = false;
  bool _loadingBottom = false;
  PixelsModel? _model;

  bool get loading => _loading;
  bool get loadingBottom => _loadingBottom;

  PixelsModel? getModel() {
    if (_model == null) {
      return null;
    } else {
      return _model;
    }
  }

  void setLoadingStatus(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setBottomLoadingStatus(bool value) {
    _loadingBottom = value;
    notifyListeners();
  }

  Future<bool> fetchWallPager() async {
    setLoadingStatus(true);
    var (model, status) = await apiService.fetchCurated();
    setLoadingStatus(false);
    if (status) {
      _model = model;
    }
    return status;
  }

  Future<bool> fetchMoreWallPager() async {
    setBottomLoadingStatus(true);
    var (model, status) = await apiService.fetchMoreCurated();

    if (status) {
      _model!.photos.addAll(model.photos);
    }
    return status;
  }
}
