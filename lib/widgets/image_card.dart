import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mywallpaper/extra/wallpaper_model.dart';
import 'package:mywallpaper/screens/set_wallpaper_screen.dart';

class ImageCard extends StatelessWidget {
  final WallpaperModel wallpaper;

  const ImageCard({Key? key, required this.wallpaper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetWallpaperScreen(
              wallpaper: wallpaper,
            ),
          ),
        );
      },
      child: Neumorphic(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(wallpaper.thumbnail),
        ),
      ),
    );
  }
}
