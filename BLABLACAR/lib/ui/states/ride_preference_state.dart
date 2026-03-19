import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';

class RidepreferencesState extends ChangeNotifier {
  final RidePreferenceRepository rideRepo;
  RidePreference? _currentPref;
  List<RidePreference> _history = [];

  RidepreferencesState({required this.rideRepo});

  RidePreference? get ridePreference => _currentPref;
  List<RidePreference> get history => _history;

  Future<void> init() async {
    _history = await rideRepo.getPreferenceHistory();
    notifyListeners();
  }

  Future<void> selectedPreference(RidePreference pref) async {
    if (_currentPref == pref) return;
    _currentPref = pref;
    _history = await rideRepo.addPreferenceToHistory(pref);
    notifyListeners();
  }
}
