part of 'wallpaper_bloc.dart';

sealed class WallpaperState extends Equatable {
  const WallpaperState();
  
  @override
  List<Object> get props => [];
}

final class WallpaperInitial extends WallpaperState {}
