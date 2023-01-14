import 'package:flutter/material.dart';
import 'package:mapbox_app/screen/prepare_ride_screen.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../helpers/shared_prefs.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 LatLng currentLocation = getCurrentLatLngFromSharedPrefs();
  late String currentAddress;
  late CameraPosition _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: currentLocation, zoom: 14);
    currentAddress = getCurrentAddressFromSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        MapboxMap(
          accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
          initialCameraPosition: _initialCameraPosition,
          myLocationEnabled: true,
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Hi there!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const Text('You are currently here:'),
                      Text(currentAddress,
                          style: const TextStyle(color: Colors.indigo)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const PrepareRideScreen()));
                                  },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Where do you wanna go today?'),
                              ],),),
                    ],),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}