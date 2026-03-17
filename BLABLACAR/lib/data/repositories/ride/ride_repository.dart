import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

abstract class RideRepository {
  Future<List<Ride>> getAllRides();
  Future<List<Ride>> getRidesFor(RidePreference ridePreference);
}
