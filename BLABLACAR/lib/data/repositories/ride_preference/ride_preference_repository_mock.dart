import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

class RidePreferenceRepositoryMock implements RidePreferenceRepository {
  static final List<RidePreference> _preferenceHistory = [];
  @override
  Future<void> addPreferenceToHistory(RidePreference ridePreference) async {
    try {
      _preferenceHistory.add(ridePreference);
    } catch (e) {
      throw Exception('Failed To Save Ride Preference.');
    }
  }

  @override
  Future<List<RidePreference>> getPreferenceHistory() async {
    try {
      return _preferenceHistory;
    } catch (e) {
      throw Exception('No Ride Preference Found');
    }
  }
}
