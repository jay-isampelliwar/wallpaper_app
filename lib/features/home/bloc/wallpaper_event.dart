part of 'wallpaper_bloc.dart';

abstract class WallpaperEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialFetchEvent extends WallpaperEvent {
  @override
  List<Object> get props => [];
}

class WallpaperInitialFetchEvent extends WallpaperEvent {}

class WallpaperClickEvent extends WallpaperEvent {}

class WallpaperFetchMoreEvent extends WallpaperEvent {}
