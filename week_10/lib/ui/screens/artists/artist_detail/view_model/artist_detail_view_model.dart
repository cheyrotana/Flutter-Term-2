import 'package:flutter/material.dart';
import 'package:week_9/data/repositories/artist/artist_repository.dart';
import 'package:week_9/data/repositories/songs/song_repository.dart';
import 'package:week_9/model/artist/artist.dart';
import 'package:week_9/model/comments/comment.dart';
import 'package:week_9/model/songs/song.dart';
import 'package:week_9/ui/utils/async_value.dart';

class ArtistDetailViewModel extends ChangeNotifier {
  final ArtistRepository artistRepo;
  final SongRepository songRepo;

  final Artist artist;
  AsyncValue<List<Song>> songsValue = AsyncValue.loading();
  AsyncValue<List<Comment>> commentsValue = AsyncValue.loading();

  ArtistDetailViewModel({
    required this.artistRepo,
    required this.songRepo,
    required this.artist,
  }) {
    _init();
  }

  // Fetch songs and comments in parallel to reduce loading time
  void _init() async {
    await Future.wait([_fetchSong(), _fetchComments()]);
  }

  Future<void> _fetchSong() async {
    songsValue = AsyncValue.loading();
    notifyListeners();
    try {
      final List<Song> allSongs = await songRepo.fetchSongs();
      songsValue = AsyncValue.success(
        allSongs.where((song) => song.artistId == artist.id).toList(),
      );
    } catch (e) {
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  Future<void> _fetchComments() async {
    commentsValue = AsyncValue.loading();
    notifyListeners();
    try {
      final List<Comment> comments = await artistRepo.fetchArtistComments(
        artist.id,
      );
      commentsValue = AsyncValue.success(comments);
    } catch (e) {
      commentsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void likeSong(String id) async {
    try {
      final Song updatedSong = await songRepo.likeSong(id);

      final List<Song> currentSongs = songsValue.data!;
      final List<Song> updatedSongs = [];

      for (var song in currentSongs) {
        if (song.id == id) {
          updatedSongs.add(updatedSong);
        } else {
          updatedSongs.add(song);
        }
      }
      songsValue = AsyncValue.success(updatedSongs);
    } catch (e) {
      songsValue = AsyncValue.error(e);
    }

    notifyListeners();
  }

  void addComment(String text) async {
    try {
      final Comment newComment = await artistRepo.postComment(artist.id, text);

      final List<Comment> currentComments = commentsValue.data!;
      final List<Comment> updatedComments = [];

      for (final comment in currentComments) {
        updatedComments.add(comment);
      }
      updatedComments.add(newComment);

      commentsValue = AsyncValue.success(updatedComments);
      
    } catch (e) {
      commentsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
