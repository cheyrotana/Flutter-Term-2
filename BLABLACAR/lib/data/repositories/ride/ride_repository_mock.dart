import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/data/repositories/ride/ride_repository.dart';
import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

class RideRepositoryMock implements RideRepository {
  @override
  Future<List<Ride>> getAllRides() async {
    try {
      final List<Ride> allRides = fakeRides;
      return allRides;
    } catch (e) {
      throw Exception('No Rides Found.');
    }
  }

  @override
  Future<List<Ride>> getRidesFor(RidePreference ridePreference) async {
    try {
      final allRides = await getAllRides();
      return allRides
          .where(
            (ride) =>
                ride.departureLocation == ridePreference.departure &&
                ride.arrivalLocation == ridePreference.arrival &&
                ride.availableSeats >= ridePreference.requestedSeats,
          )
          .toList();
    } catch (e) {
      throw Exception('No Rides Found.');
    }
  }
}
