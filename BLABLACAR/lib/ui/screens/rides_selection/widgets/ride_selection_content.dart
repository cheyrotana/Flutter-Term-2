import 'package:blabla/ui/screens/rides_selection/view_model/ride_selection_view_model.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/rides_selection_header.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/rides_selection_tile.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class RideSelectionContent extends StatelessWidget {
  const RideSelectionContent({super.key, required this.rv});

  final RideSelectionViewModel rv;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            RideSelectionHeader(
              ridePreference: rv.selectedRidePreference,
              onBackPressed: () => rv.onBackTap(context),
              onFilterPressed: rv.onFilterPressed,
              onPreferencePressed: () => rv.onPreferencePressed(context, rv.selectedRidePreference),
            ),

            SizedBox(height: 100),

            Expanded(
              child: ListView.builder(
                itemCount: rv.matchingRides.length,
                itemBuilder: (ctx, index) => RideSelectionTile(
                  ride: rv.matchingRides[index],
                  onPressed: () => rv.onRideSelected(rv.matchingRides[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
