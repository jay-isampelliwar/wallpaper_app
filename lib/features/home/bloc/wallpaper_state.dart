part of 'wallpaper_bloc.dart';

abstract class WallpaperState extends Equatable {
  const WallpaperState();

  @override
  List<Object> get props => [];
}

abstract class WallpaperActionState extends WallpaperState {}

final class WallpaperInitial extends WallpaperState {}

class WallpaperLoadingState extends WallpaperState {}

class WallpaperErrorState extends WallpaperActionState {
  String message;
  WallpaperErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class WallpaperBottomLoadingState extends WallpaperState {}

class WallpaperSuccessState extends WallpaperState {
  PixelsModel data;
  WallpaperSuccessState({required this.data});

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class WallpaperFetchMoreSuccessState extends WallpaperState {
  List<Photo> photos;
  WallpaperFetchMoreSuccessState({required this.photos});
  @override
  // TODO: implement props
  List<Object> get props => [photos];
}
