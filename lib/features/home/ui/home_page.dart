import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/features/home/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/features/home/model/pexels_data_model.dart';
import 'package:wallpaper_app/utils/routes/routes_name.dart';
import 'package:wallpaper_app/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WallpaperBloc wallpaperBloc = WallpaperBloc();
  ScrollController scrollController = ScrollController();
  PixelsModel? model;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      wallpaperBloc.add(WallpaperInitialFetchEvent());
    });

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          wallpaperBloc.add(WallpaperFetchMoreEvent());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: BlocConsumer<WallpaperBloc, WallpaperState>(
        bloc: wallpaperBloc,
        listenWhen: (previous, current) => current is WallpaperActionState,
        buildWhen: (previous, current) => current is! WallpaperActionState,
        listener: (context, state) {
          if (state is WallpaperErrorState) {
            String errorMessage = state.message;
            Utils.showErrorSnackBar(context, errorMessage);
          }
        },
        builder: (context, state) {
          if (state is WallpaperLoadingState) {
            return Center(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 3),
                      color: Colors.grey,
                      blurRadius: 3,
                    )
                  ],
                  shape: BoxShape.circle,
                ),
                child: const Align(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          } else if (state is WallpaperSuccessState) {
            if (model != null) {
              model!.photos.addAll(state.data.photos);
            } else {
              model = state.data;
            }

            return Stack(
              children: [
                GridView.builder(
                  controller: scrollController,
                  itemCount: model!.photos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    String imageUrl = model!.photos[index].src.portrait;
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.display,
                            arguments: imageUrl);
                      },
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                Visibility(
                  visible: false,
                  child: Align(
                    alignment: const Alignment(0, 0.85),
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            color: Colors.grey,
                            blurRadius: 3,
                          )
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: const Align(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
