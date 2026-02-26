import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'viewer_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {

  List<AssetEntity> images = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {

    final PermissionState ps =
    await PhotoManager.requestPermissionExtend();

    if (!ps.isAuth) {
      setState(() => loading = false);
      return;
    }

    final List<AssetPathEntity> albums =
    await PhotoManager.getAssetPathList(type: RequestType.image);

    final List<AssetEntity> media =
    await albums[0].getAssetListPaged(page: 0, size: 100);

    setState(() {
      images = media;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (images.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No se encontraron fotos",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Galería")),

      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),

        itemCount: images.length,

        itemBuilder: (context, index) {

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ViewerScreen(
                    images: images,
                    initialIndex: index,
                  ),
                ),
              );
            },

            child: Hero(
              tag: images[index].id,

              child: FutureBuilder<Uint8List?>(
                future: images[index].thumbnailDataWithSize(
                  const ThumbnailSize(300, 300),
                ),
                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return Container(color: Colors.grey.shade200);
                  }

                  return Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}