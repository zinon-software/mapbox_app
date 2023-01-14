import 'package:flutter/material.dart';
import 'package:mapbox_app/screen/review_ride_screen.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/mapbox_handler.dart';
import '../helpers/shared_prefs.dart';

Widget reviewRideFaButton(BuildContext context) {
  return FloatingActionButton.extended(
      icon: const Icon(Icons.local_taxi),
      onPressed: () async {
        LatLng sourceLatLng = getTripLatLngFromSharedPrefs('source');
        LatLng destinationLatLng = getTripLatLngFromSharedPrefs('destination');
        Map modifiedResponse =
            await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    ReviewRideScreen(modifiedResponse: modifiedResponse)));
      },
      label: const Text('Review Ride'));
}