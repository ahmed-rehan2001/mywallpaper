import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mywallpaper/cubit/wallpaper_cubit.dart';
import 'package:mywallpaper/extra/constants.dart';


class NotFoundIllustration extends StatelessWidget {
  const NotFoundIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 200,
          height: 300,
          child: SvgPicture.asset(notFoundIllustration),
        ),
        ElevatedButton(
          onPressed: () => context.read<WallpaperCubit>().getWallpaper(),
          child: const Text('Retry'),
        )
      ],
    );
  }
}