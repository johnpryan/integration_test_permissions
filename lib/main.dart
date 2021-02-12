import 'package:flutter/material.dart';

import 'package:location/location.dart';

void main() {
  runApp(LocationApp());
}

class LocationApp extends StatefulWidget {
  @override
  _LocationAppState createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  Location location = Location();
  LocationData _locationData;

  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_locationData != null)
                Text('Location: '
                    '${_locationData.latitude} ${_locationData.longitude}')
              else
                Text('Getting location...'),
            ],
          ),
        ),
      ),
    );
  }

  void getLocation() async {
    var enabled = await location.serviceEnabled();
    print('enabled: $enabled');
    if (!enabled) {
      print('requestService');
      enabled = await location.requestService();
      print('enabled: $enabled');
      if (!enabled) {
        return;
      }
    }

    var granted = await location.hasPermission();
    print('hasPermission: $granted');
    if (granted == PermissionStatus.denied) {
      print('requesting permission');
      granted = await location.requestPermission();
      print('requestPermission: $granted');
      if (granted != PermissionStatus.granted) {
        return;
      }
    }

    print('getLocation()');
    var data = await location.getLocation();
    print('location data: $data');
    setState(() {
      _locationData = data;
    });
  }
}
