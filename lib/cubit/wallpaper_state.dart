part of 'wallpaper_cubit.dart';

@immutable
abstract class WallpaperState {}

class WallpaperInitial extends WallpaperState {}
class WallpaperLoading extends WallpaperState {}

class WallpaperLoaded extends WallpaperState {
  final List <WallpaperModel> wallpaper;

  WallpaperLoaded({required this.wallpaper});
}

class WallpaperError extends WallpaperState {
  final String message;

  WallpaperError({required this.message});
}

class WallpaperAppliedSuccess extends WallpaperState {}

class WallpaperAppliedFailed extends WallpaperState {}
