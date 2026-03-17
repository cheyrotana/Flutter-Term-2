import 'package:blabla/model/ride_pref/ride_pref.dart';

abstract class RidePreferenceRepository {
  Future<List<RidePreference>> getPreferenceHistory();
  Future<void> addPreferenceToHistory(RidePreference ridePreference);
}
