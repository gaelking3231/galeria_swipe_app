import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ViewerScreen extends StatefulWidget {
  final List<AssetEntity> images;
  final int initialIndex;

  const ViewerScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<ViewerScreen> createState() => _ViewerScreenState();
}

class _ViewerScreenState extends State<ViewerScreen> {

  late final PageController controller;

  /// 😈 CACHE
  final Map<int, Uint8List?> cache = {};

  @override
  void initState() {
    super.initState();

    controller = PageController(initialPage: widget.initialIndex);

    preload(widget.initialIndex);
  }

  Future<void> preload(int index) async {

    loadImage(index);

    if (index + 1 < widget.images.length) {
      loadImage(index + 1);
    }

    if (index - 1 >= 0) {
      loadImage(index - 1);
    }
  }

  Future<void> loadImage(int index) async {

    if (cache.containsKey(index)) return;

    final data = await widget.images[index]
        .thumbnailDataWithSize(const ThumbnailSize(1200, 1200));

    setState(() {
      cache[index] = data;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "${controller.hasClients ? controller.page?.round() ?? widget.initialIndex : widget.initialIndex + 1} / ${widget.images.length}",
        ),
      ),

      body: PageView.builder(

        controller: controller,
        itemCount: widget.images.length,

        onPageChanged: (index) {
          preload(index);
        },

        itemBuilder: (context, index) {

          final imageData = cache[index];

          if (imageData == null) {
            loadImage(index);
          }

          return Center(
            child: Hero(
              tag: widget.images[index].id,

              child: InteractiveViewer(   /// 😈 ZOOM RESTORED
                minScale: 0.8,
                maxScale: 4,

                child: imageData == null
                    ? const CircularProgressIndicator()
                    : Image.memory(
                  imageData,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}