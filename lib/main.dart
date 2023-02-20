import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywallpaper/cubit/wallpaper_cubit.dart';
import 'package:mywallpaper/extra/constants.dart';

import 'screens/wallpaper_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WallpaperCubit()..getWallpaper(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wall Paper',
        theme: theme,
        home: const WallpaperScreen(),
      ),
    );
  }
}
