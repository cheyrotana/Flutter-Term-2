import 'package:blabla/data/repositories/ride/ride_repository.dart';
import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/ride_preference_modal.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:blabla/utils/animations_util.dart';
import 'package:flutter/material.dart';

class RideSelectionViewModel extends ChangeNotifier {
  final RidepreferencesState _ridepreferencesState;
  final RideRepository _rideRepository;
  late List<Ride> _matchingRides = [];
  RideSelectionViewModel({
    required RidepreferencesState ridepreferencesState,
    required RideRepository rideRepository,
  }) : _rideRepository = rideRepository,
       _ridepreferencesState = ridepreferencesState {
    _ridepreferencesState.addListener(_onRidePrefChanged);
    _loadRides();
  }

  void _onRidePrefChanged() async {
    await _loadRides();
    notifyListeners();
  }

  @override
  void dispose() {
    _ridepreferencesState.removeListener(_onRidePrefChanged);
    super.dispose();
  }

  RidePreference get selectedRidePreference =>
      _ridepreferencesState.ridePreference!;
  List<RidePreference> get history => _ridepreferencesState.history;
  List<Ride> get matchingRides => _matchingRides;

  Future<void> _loadRides() async {
    _matchingRides = await _rideRepository.getRidesFor(selectedRidePreference);
    notifyListeners();
  }

  void onBackTap(BuildContext context) {
    Navigator.pop(context);
  }

  void onFilterPressed() {
    // TODO
  }

  void onRideSelected(Ride ride) {
    // Later
  }

  void onPreferencePressed(
    BuildContext context,
    RidePreference selectedPreference,
  ) async {
    // 1 - Navigate to the rides preference picker
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(initialPreference: selectedPreference),
          ),
        );

    if (newPreference != null) {
      _ridepreferencesState.selectedPreference(newPreference);
      notifyListeners();
    }
  }
}
