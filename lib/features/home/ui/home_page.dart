import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/features/home/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/features/home/model/pexels_data_model.dart';

import '../../../utils/routes/routes_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  WallpaperBloc wallpaperBloc = WallpaperBloc();
  ScrollController scrollController = ScrollController();
  late AnimationController animationController;
  late Animation<double> alignmentController;
  PixelsModel? model;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    alignmentController = Tween<double>(begin: 0.0, end: 0.15).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn));

    Future.delayed(Duration.zero, () {
      wallpaperBloc.add(WallpaperInitialFetchEvent());
    });

    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        if (scrollController.position.extentAfter != 0) {
          // }
        } else if (scrollController.position.extentAfter == 0) {
          animationController.forward();
          wallpaperBloc.add(WallpaperFetchMoreEvent());
          // if (status) {
          await animationController.reverse();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: BlocConsumer(
          bloc: wallpaperBloc,
          builder: (context, state) {
            if (state is WallpaperLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WallpaperSuccessState) {
              if (model == null) {
                model = state.data;
              } else {
                model!.photos.addAll(state.data.photos);
              }

              return Stack(
                children: [
                  GridView.builder(
                    controller: scrollController,
                    itemCount: model!.photos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      String imageUrl = model!.photos[index].src.portrait;
                      String tag = index.toString();
                      return GestureDetector(
                        onTap: () {
                          Map<String, String> arguments = {
                            "url": imageUrl,
                            "tag": tag
                          };
                          Navigator.pushNamed(context, RoutesName.display,
                              arguments: arguments);
                        },
                        child: Hero(
                          tag: tag,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  Visibility(
                    visible: state is WallpaperBottomLoadingState,
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return Align(
                          alignment: Alignment(
                              0, (1 - animationController.value) + 0.85),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 3),
                                  color: Colors.grey.shade200,
                                  blurRadius: 3,
                                )
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              child: CircularProgressIndicator(
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
            return const SizedBox();
          },
          listener: (context, state) {},
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wallpaper_app/features/home/model/pexels_data_model.dart';

// import '../../../provider/wallpaper_provider.dart';
// import '../../../utils/routes/routes_name.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   ScrollController scrollController = ScrollController();
//   late AnimationController animationController;
//   late Animation<double> alignmentController;
//   @override
//   void initState() {
//     super.initState();

//     animationController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 300));
//     alignmentController = Tween<double>(begin: 0.0, end: 0.15).animate(
//         CurvedAnimation(parent: animationController, curve: Curves.bounceIn));

//     Future.delayed(Duration.zero, () {
//       Provider.of<WallpaperProvider>(context, listen: false).fetchWallPager();
//     });

//     scrollController.addListener(() async {
//       if (scrollController.position.atEdge) {
//         if (scrollController.position.pixels != 0) {
//           animationController.forward();
//           bool status =
//               await Provider.of<WallpaperProvider>(context, listen: false)
//                   .fetchMoreWallPager();
//           if (status) {
//             await animationController.reverse();
//             Provider.of<WallpaperProvider>(context, listen: false)
//                 .setBottomLoadingStatus(false);
//           }
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.grey.shade900,
//         body: Consumer<WallpaperProvider>(
//           builder: (context, provider, child) {
//             bool loading = provider.loading;
//             bool loadingBottom = provider.loadingBottom;
//             PixelsModel? model = provider.getModel();
//             if (model == null || loading) {
//               return const Center(child: CircularProgressIndicator());
//             } else {
              // return Stack(
              //   children: [
              //     GridView.builder(
              //       controller: scrollController,
              //       itemCount: model.photos.length,
              //       gridDelegate:
              //           const SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 2),
              //       itemBuilder: (context, index) {
              //         String imageUrl = model.photos[index].src.portrait;
              //         String tag = index.toString();
              //         return GestureDetector(
              //           onTap: () {
              //             Map<String, String> arguments = {
              //               "url": imageUrl,
              //               "tag": tag
              //             };
              //             Navigator.pushNamed(context, RoutesName.display,
              //                 arguments: arguments);
              //           },
              //           child: Hero(
              //             tag: tag,
              //             child: Image.network(
              //               imageUrl,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //     Visibility(
              //       visible: loadingBottom,
              //       child: AnimatedBuilder(
              //         animation: animationController,
              //         builder: (context, child) {
              //           return Align(
              //             alignment: Alignment(
              //                 0, (1 - animationController.value) + 0.85),
              //             child: Container(
              //               height: 50,
              //               decoration: BoxDecoration(
              //                 color: Colors.grey.shade900,
              //                 boxShadow: [
              //                   BoxShadow(
              //                     offset: const Offset(0, 3),
              //                     color: Colors.grey.shade200,
              //                     blurRadius: 3,
              //                   )
              //                 ],
              //                 shape: BoxShape.circle,
              //               ),
              //               child: Align(
              //                 child: CircularProgressIndicator(
              //                   color: Colors.grey.shade200,
              //                 ),
              //               ),
              //             ),
              //           );
              //         },
              //       ),
              //     )
              //   ],
              // );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
// }
