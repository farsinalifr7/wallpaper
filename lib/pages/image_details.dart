// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class ImagePage extends StatefulWidget {
  final String image;
  const ImagePage({
    super.key,
    required this.image,
  });

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Image.network(
            widget.image,
            fit: BoxFit.cover,
          )),
          Container(
            color: Colors.black,
            height: 40,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setWallPaper();
                },
                child: const Text(
                  "Set as Wallpaper",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> setWallPaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.image);

    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);

    print(result);
  }
}
