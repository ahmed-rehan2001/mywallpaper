import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mywallpaper/cubit/wallpaper_cubit.dart';
import 'package:mywallpaper/extra/constants.dart';
import 'package:mywallpaper/extra/wallpaper_model.dart';
import 'package:mywallpaper/widgets/image_card.dart';
import 'package:mywallpaper/widgets/loder.dart';
import 'package:mywallpaper/widgets/not_found.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({Key? key}) : super(key: key);

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        elevation: 0,
        toolbarHeight: 0.0,
      ),
      backgroundColor: creamWhite,
      body: Column(
        children: [
          const Text(
            'My Wallpaper',
            style: TextStyle(fontSize: 40, fontFamily: handlee),
          ),
          Neumorphic(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: _controller,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: InputBorder.none,
                  hintText: 'Search Wallpaper',
                  hintStyle: const TextStyle(color: grey),
                  suffixIcon: ElevatedButton(
                      onPressed: () {
                        context
                            .read<WallpaperCubit>()
                            .getWallpaper(_controller.text);
                      },
                      child: const Icon(Icons.search))),
              onSubmitted: (value) {
                context.read<WallpaperCubit>().getWallpaper(_controller.text);
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<WallpaperCubit, WallpaperState>(
              listener: (_, state) {},
              builder: (_, state) {
                if (state is WallpaperLoading) {
                  return const Center(child: BubbleLoad());
                } else if (state is WallpaperError) {
                  return  const NotFoundIllustration();
                }
                List<WallpaperModel> wallpapers = [];
                if (state is WallpaperLoaded) {
                  wallpapers = (state).wallpaper;
                }

                wallpapers = context.read<WallpaperCubit>().wallpapers;

                return MasonryGridView.count(
                    itemCount: wallpapers.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    itemBuilder: (_, index) {
                      return ImageCard(
                        wallpaper: wallpapers[index],
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
