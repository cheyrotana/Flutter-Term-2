abstract class UserHistoryRepository {
  List<String> fetchRecentSongIds();

  void addToRecent(String songId);
}
