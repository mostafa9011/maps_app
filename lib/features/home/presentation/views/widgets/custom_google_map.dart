import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/utils/services/location_service.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? _googleMapController;
  // String? _mapStyle;
  final LocationService _locationService = LocationService.instance;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
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

    _locationService.getCurrentLocation();

    // _loadMapStyle();
  }

  // Future<void> _loadMapStyle() async {
  //   String style =
  //       await rootBundle.loadString('assets/map_styles/night_map_style.json');
  //   setState(() {
  //     _mapStyle = style;
  //   });
  // }

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context).size;
    return GoogleMap(
      // style: _mapStyle,
      markers: markers,
      onMapCreated: (controller) async {
        _googleMapController = controller;

        var locationData = await _locationService.getCurrentLocation();
        if (locationData != null) {
          log("New location data: $locationData");
          var marker = Marker(
            markerId: const MarkerId("1"),
            position: LatLng(
              locationData.latitude!,
              locationData.longitude!,
            ),
          );

          setState(() {
            markers.add(marker);
          });
          _googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  locationData.latitude!,
                  locationData.longitude!,
                ),
                zoom: 10,
              ),
            ),
          );
        }
      },
      initialCameraPosition: initialCameraPosition,
    );
  }
}
