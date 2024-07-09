import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController _googleMapController;
  @override
  void initState() {
    //zoom level (guess)
    //world view =========> 0:3
    //country view =======> 4:6
    //city view =======> 10:12
    //street view =======> 13:17
    //building view =======> 18:20

    initialCameraPosition = const CameraPosition(
      target: LatLng(29.982046652658944, 31.13728546509986), //Pyramids
      zoom: 10,
    );
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) {
            _googleMapController = controller;
          },
          initialCameraPosition: initialCameraPosition,
        ),
        Positioned(
          bottom: 10,
          left: mediaQuery.width * 0.33,
          child: ElevatedButton(
            onPressed: () {
              LatLng latLng = const LatLng(
                28.486061571963045,
                30.795758011639528,
              );
              _googleMapController.animateCamera(
                CameraUpdate.newLatLng(latLng),
              );
            },
            child: const Text(
              'Change Location',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
