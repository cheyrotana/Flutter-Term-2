import 'user_history_repository.dart';

class UserHistoryRepositoryMock implements UserHistoryRepository {
  final List<String> _recentSongIds = [];

  @override
  List<String> fetchRecentSongIds() {
    // Return an unmodifiable copy so callers can't mutate the list directly.
    // All changes must go through addToRecent() to keep history consistent.
    return List.unmodifiable(_recentSongIds);
  }

  @override
  void addToRecent(String songId) {
    // Remove the ID if it already exists to avoid duplicates
    _recentSongIds.remove(songId);
    // Insert at index 0 so the most recently played song is always first.
    _recentSongIds.insert(0, songId);
  }
}
