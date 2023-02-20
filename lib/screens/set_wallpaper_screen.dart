import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywallpaper/cubit/wallpaper_cubit.dart';
import 'package:mywallpaper/extra/constants.dart';
import 'package:mywallpaper/extra/location_enum.dart';
import 'package:mywallpaper/extra/wallpaper_model.dart';
import 'package:mywallpaper/widgets/loder.dart';

import '../extra/snackbar.dart';

class SetWallpaperScreen extends StatefulWidget {
  final WallpaperModel wallpaper;

  const SetWallpaperScreen({Key? key, required this.wallpaper})
      : super(key: key);

  @override
  State<SetWallpaperScreen> createState() => _SetWallpaperScreenState();
}

class _SetWallpaperScreenState extends State<SetWallpaperScreen> {
  File? wallpaperFile;

  @override
  void initState() {
    super.initState();
    context
        .read<WallpaperCubit>()
        .downloadWallpaper(widget.wallpaper.original)
        .then((file) {
      setState(() {
        wallpaperFile = file;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<WallpaperCubit, WallpaperState>(
          listener: (context, state) {
            if (state is WallpaperAppliedSuccess){
              Snackbar.show(context, 'Wallpaper applied successfully', true);
            }
            if (state is WallpaperAppliedFailed){
              Snackbar.show(context, 'Failed to download Wallpaper', false);
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              wallpaperFile == null
                  ? const SizedBox()
                  : Image.file(
                      wallpaperFile!,
                      fit: BoxFit.cover,
                    ),
              if (wallpaperFile == null)
                const BubbleLoad()
              else if (wallpaperFile != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              context.read<WallpaperCubit>().setWallpaper(
                                  wallpaperFile!.path, WallpaperLocation.home);
                            },
                            child: const Text(
                              'Home Screen',
                              style: TextStyle(),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              context.read<WallpaperCubit>().setWallpaper(
                                  wallpaperFile!.path, WallpaperLocation.lock);
                            },
                            child: const Text(
                              'Lock Screen',
                              style: TextStyle(),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              context.read<WallpaperCubit>().setWallpaper(
                                  wallpaperFile!.path, WallpaperLocation.both);
                            },
                            child: const Text(
                              'Both',
                              style: TextStyle(),
                            )),
                      ],
                    ),
                  ),
                ),
              Positioned(
                top: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
