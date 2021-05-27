import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class SampleCodeWidget extends StatefulWidget {
  @override
  _SampleCodeState createState() {
    return _SampleCodeState();
  }
}

class _SampleCodeState extends State<SampleCodeWidget> {
  static const List<String> accuracyValues = <String>[
    "powerSave",
    "low",
    "balanced",
    "high",
    "navigation"
  ];
  int _currentAccuracyValue = 3;
  double _currentTimer = 3000.0;
  double _currentDistance = 0.0;

  Location _location;
  StreamSubscription _locationSubscription;
  LocationData _locationData;

  @override
  void initState() {
    super.initState();
    _location = new Location();
  }

  void _toggleLocationUpdates() {
    if (_locationSubscription == null) {
      _locationSubscription =
          _location.onLocationChanged.listen((LocationData currentLocation) {
        setState(() {
          _locationData = currentLocation;
        });
      });
    } else {
      _locationSubscription.cancel();
      _locationSubscription = null;
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    _location.changeSettings(
        accuracy: LocationAccuracy.values[_currentAccuracyValue],
        interval: _currentTimer.toInt(),
        distanceFilter: _currentDistance);
    return Column(
        children: ListTile.divideTiles(
      context: context,
      tiles: <Widget>[
        ListTile(
          leading: Icon(Icons.architecture, color: Colors.orange),
          title: Slider(
            value: _currentAccuracyValue.toDouble(),
            min: 0,
            max: 4,
            divisions: 4,
            label: accuracyValues[_currentAccuracyValue],
            onChanged: _locationSubscription != null
                ? null
                : (double value) {
                    setState(() {
                      _currentAccuracyValue = value.toInt();
                    });
                  },
          ),
        ),
        ListTile(
          leading: Icon(Icons.timer, color: Colors.deepPurple),
          title: Slider(
            value: _currentTimer,
            min: 1000.0,
            max: 15 * 60 * 1000.0,
            onChanged: _locationSubscription != null
                ? null
                : (double value) {
                    setState(() {
                      _currentTimer = value;
                    });
                  },
          ),
          trailing: Container(
              width: 45.0,
              child: Text(_currentTimer < 60000
                  ? "${(_currentTimer / 1000.0).round()}sec"
                  : "${(_currentTimer / 60000.0).round()}min")),
        ),
        ListTile(
          leading: Icon(Icons.adjust, color: Colors.lightGreen),
          title: Slider(
            value: _currentDistance,
            min: 0.0,
            max: 1000.0,
            onChanged: _locationSubscription != null
                ? null
                : (double value) {
                    setState(() {
                      _currentDistance = value;
                    });
                  },
          ),
          trailing: Container(
              width: 45.0,
              child: Text(_currentDistance < 1000
                  ? "${_currentDistance.toInt()}m"
                  : "${(_currentDistance / 1000.0).round()}km")),
        ),
        TextButton(
            onPressed: _toggleLocationUpdates,
            child: Text(_locationSubscription != null
                ? "Stop Location Updates"
                : "Start Location Updates")),
        if (_locationSubscription != null && _locationData != null)
          Column(
            children: [
              Row(children: [
                Text("Longitude: "),
                Text(_locationData.longitude.toString() + "m"),
              ]),
              Row(children: [
                Text("Latitude: "),
                Text(_locationData.latitude.toString() + "m"),
              ]),
              Row(children: [
                Text("Accuracy: "),
                Text(_locationData.accuracy.toString() + "m"),
              ]),
              Row(children: [
                Text("Altitude: "),
                Text(_locationData.altitude.toString() + "m above sea level"),
              ]),
              Row(children: [
                Text("Heading: "),
                Text(_locationData.heading.toString() + "°"),
              ]),
              Row(children: [
                Text("Speed: "),
                Text(_locationData.speed.toString() + "m/sec"),
              ]),
              Row(children: [
                Text("Speed Accuracy: "),
                Text(_locationData.speedAccuracy.toString() + "m/sec"),
              ]),
              Row(children: [
                Text("Time: "),
                Text(DateTime.fromMillisecondsSinceEpoch(
                        _locationData.time.toInt())
                    .toString()),
              ])
            ],
          ),
      ],
    ).toList());
  }
}
