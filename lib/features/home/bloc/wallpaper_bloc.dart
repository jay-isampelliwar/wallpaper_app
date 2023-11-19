import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wallpaper_app/features/home/model/pexels_data_model.dart';
import 'package:wallpaper_app/services/api_service.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  ApiService apiService = ApiService();
  WallpaperBloc() : super(WallpaperInitial()) {
    on<WallpaperInitialFetchEvent>(wallpaperInitialFetchEvent);
    on<WallpaperFetchMoreEvent>(wallpaperFetchMoreEvent);
    on<WallpaperClickEvent>(wallpaperClickEvent);
  }
//
  FutureOr<void> wallpaperInitialFetchEvent(
      WallpaperInitialFetchEvent event, Emitter<WallpaperState> emit) async {
    emit(WallpaperLoadingState());
    var (model, status) = await apiService.fetchCurated();
    if (status) {
      emit(WallpaperSuccessState(data: model!));
    
    } else {
      emit(WallpaperErrorState(
          message: "Something went wrong, while fetching data"));
    }
  }

  FutureOr<bool> wallpaperFetchMoreEvent(
      WallpaperFetchMoreEvent event, Emitter<WallpaperState> emit) async {
    emit(WallpaperBottomLoadingState());
    var (model, status) = await apiService.fetchMoreCurated();
    if (status) {
      emit(WallpaperSuccessState(data: model));
    } else {
      emit(WallpaperErrorState(
          message: "Something went wrong, while fetching data"));
    }

    return status;
  }

  FutureOr<void> wallpaperClickEvent(
      WallpaperClickEvent event, Emitter<WallpaperState> emit) {}
}
