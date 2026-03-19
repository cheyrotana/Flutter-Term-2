import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/screens/rides_selection/rides_selection_screen.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:blabla/utils/animations_util.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final RidepreferencesState _ridepreferencesState;

  HomeViewModel({required RidepreferencesState ridepreferencesState})
    : _ridepreferencesState = ridepreferencesState {
    _ridepreferencesState.addListener(_onRidePrefChanged);
  }

  void _onRidePrefChanged() {
    notifyListeners();
  }

  // Expose data from the state
  RidePreference? get currentPreference => _ridepreferencesState.ridePreference;
  List<RidePreference> get history => _ridepreferencesState.history;

  @override
  void dispose() {
    _ridepreferencesState.removeListener(_onRidePrefChanged);
    super.dispose();
  }

  void onRidePrefSelected(
    BuildContext context,
    RidePreference selectedPreference,
  ) async {
    _ridepreferencesState.selectedPreference(selectedPreference);

    await Navigator.of(
      context,
    ).push(AnimationUtils.createBottomToTopRoute(RidesSelectionScreen()));

    notifyListeners();
  }
}
