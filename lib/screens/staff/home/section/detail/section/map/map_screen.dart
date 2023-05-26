import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_directions/flutter_map_directions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import "package:http/http.dart" as http;
import 'package:staff_cleaner/values/algorithm_greedy.dart';
import 'package:staff_cleaner/values/output_utils.dart';

import '../../../../../../../values/constant.dart';

class MapScreen extends StatefulWidget {
  final Map<String, dynamic>? lokasi;

  const MapScreen({super.key, this.lokasi});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _message = 'Finding route...';
  final double _defaultStrokeWidth = 3.0;
  final Color _defaultColor = Colors.blue;

  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  List<LatLng>? coordinates;

  var listRoute = [];

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast("Location services are disabled. Please enable the services");
      logO("permission", m: "Location services are disabled. Please enable the services");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast("Location permissions are denied");
        logO("permission", m: "Location permissions are denied");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showToast("Location permissions are permanently denied, we cannot request permissions.");
      logO("permission",
          m: "Location permissions are permanently denied, we cannot request permissions.");
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      getDistance(position);
    }).catchError((e) {
      logO("e", m: e);
    });
    positionStream();
  }

  StreamSubscription<Position> positionStream() {
    return Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      if (position != null) {
        getDistance(position);
      }

      logO("position",
          m: position == null
              ? 'Unknown'
              : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
  }

  void getDistance(Position position) async {
    try {
      var targetLatitude = widget.lokasi!["latitude"];
      var targetLongitude = widget.lokasi!["longitude"];

      var url =
          "https://api.tomtom.com/routing/1/calculateRoute/${position.latitude},${position.longitude}:$targetLatitude,$targetLongitude/json?key=$apiKey&maxAlternatives=5";
      logO("url", m: url);
      var result = await http.get(Uri.parse(url));
      var res = json.decode(result.body)['routes'];

      var routes = [];

      for (var e in res) {
        var points = e["legs"][0]["points"];
        routes.add(points);
      }

      var a = algorithmGreedy(routes);

      setState(() {
        listRoute = a;
        coordinates = [
          LatLng(position.latitude, position.longitude),
          LatLng(double.parse(targetLatitude), double.parse(targetLongitude))
        ];
      });
    } catch (e) {
      showToast(e);
      logO("e", m: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    const padding = 50.0;

    return Scaffold(
        body: coordinates != null
            ? Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      bounds: LatLngBounds.fromPoints(coordinates!
                          .map((location) => latlong2.LatLng(location.latitude, location.longitude))
                          .toList()),
                      boundsOptions: FitBoundsOptions(
                        padding: EdgeInsets.only(
                          left: padding,
                          top: padding + MediaQuery.of(context).padding.top,
                          right: padding,
                          bottom: padding,
                        ),
                      ),
                    ),
                    nonRotatedChildren: [
                      TileLayer(
                          urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                              "{z}/{x}/{y}.png?key=$apiKey",
                          additionalOptions: const {"apiKey": apiKey}),
                      MarkerLayer(
                          markers: coordinates!.map((location) {
                        int idx = coordinates!.indexOf(location);

                        return Marker(
                            point: latlong2.LatLng(location.latitude, location.longitude),
                            width: 35,
                            height: 35,
                            builder: (context) => Icon(
                                  Icons.location_pin,
                                  color: idx == 0 ? Colors.red : Colors.black,
                                  size: 24,
                                ),
                            anchorPos: AnchorPos.align(AnchorAlign.top));
                      }).toList()),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: listRoute
                                .map((e) => latlong2.LatLng(e["latitude"]!, e["longitude"]!))
                                .toList(),
                            strokeJoin: StrokeJoin.round,
                            borderStrokeWidth: _defaultStrokeWidth,
                            color: _defaultColor,
                            borderColor: _defaultColor,
                          )
                        ],
                      )
                      // DirectionsLayer(
                      //   coordinates: coordinates,
                      //   color: Colors.deepOrange,
                      //   onCompleted: (isRouteAvailable) => _updateMessage(isRouteAvailable),
                      // ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(40)),
                      child: Text(_message),
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  void _updateMessage(bool isRouteAvailable) {
    setState(() {
      _message = isRouteAvailable ? 'Found route' : 'No route found';
    });
  }
}
