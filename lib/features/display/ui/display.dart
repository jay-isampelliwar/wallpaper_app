import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  const Display({required this.imageUrl, required this.tag, super.key});
  final String imageUrl;
  final String tag;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Stack(
        children: [
          InteractiveViewer(
            maxScale: 8,
            constrained: true,
            boundaryMargin: const EdgeInsets.all(0),
            child: Hero(
              tag: tag,
              child: Image.network(
                imageUrl,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
