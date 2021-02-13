import 'package:flutter/material.dart';

import 'package:location/location.dart';

void main() {
  runApp(LocationApp(location: Location()));
}

class LocationApp extends StatefulWidget {
  final Location location;

  LocationApp({
    this.location,
  });

  @override
  _LocationAppState createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  LocationData _locationData;

  @override
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

  Future getLocation() async {
    var enabled = await widget.location.serviceEnabled();
    if (!enabled) {
      enabled = await widget.location.requestService();
      if (!enabled) {
        return;
      }
    }

    var granted = await widget.location.hasPermission();
    if (granted == PermissionStatus.denied) {
      granted = await widget.location.requestPermission();
      if (granted != PermissionStatus.granted) {
        return;
      }
    }

    var data = await widget.location.getLocation();
    setState(() {
      _locationData = data;
    });
  }
}
