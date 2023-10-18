import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  WallpaperBloc() : super(WallpaperInitial()) {
    on<WallpaperEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
