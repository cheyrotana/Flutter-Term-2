import 'package:blabla/model/ride_pref/ride_pref.dart';

abstract class RidePreferenceRepository {
  Future<List<RidePreference>> getPreferenceHistory();
  Future<List<RidePreference>> addPreferenceToHistory(RidePreference ridePreference);
}
