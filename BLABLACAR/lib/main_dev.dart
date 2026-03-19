import 'package:blabla/data/repositories/location/location_repository.dart';
import 'package:blabla/data/repositories/location/location_repository_mock.dart';
import 'package:blabla/data/repositories/ride/ride_repository.dart';
import 'package:blabla/data/repositories/ride/ride_repository_mock.dart';
import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/data/repositories/ride_preference/ride_preference_repository_mock.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:nested/nested.dart';
import 'main_common.dart';

/// Configure provider dependencies for dev environment
List<SingleChildWidget> get devProviders {
  return [
    // 1 - Inject the location repository
    Provider<LocationRepository>(create: (_) => LocationRepositoryMock()),

    // 2 - Inject the ride repository
    Provider<RideRepository>(create: (_) => RideRepositoryMock()),

    // 3 - Inject the ride preference repository
    Provider<RidePreferenceRepository>(
      create: (_) => RidePreferenceRepositoryMock(),
    ),

    // 4 - Inject the ride preference state (global state)
    ChangeNotifierProvider<RidepreferencesState>(
      create: (context) => RidepreferencesState(
        rideRepo: context.read<RidePreferenceRepository>(),
      )..init(),
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}
