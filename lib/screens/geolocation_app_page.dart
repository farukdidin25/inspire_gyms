// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationApp extends StatefulWidget {
  const GeoLocationApp({super.key});

  @override
  State<GeoLocationApp> createState() => _GeoLocationAppState();
}

class _GeoLocationAppState extends State<GeoLocationApp> {

  Position? _currentLocation;
    late bool servicePermission = false;
    late LocationPermission permission;

    String _currentAdress = '';

    Future<Position> _getCurrentLocation() async {
      servicePermission = await Geolocator.isLocationServiceEnabled();
      if (!servicePermission) {
        if (kDebugMode) {
          print('service disabled');
        }
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      return await Geolocator.getCurrentPosition();
    }

    _getAdressFromCoordinates() async{
      try{
        List<Placemark> placemarks = await placemarkFromCoordinates(_currentLocation!.latitude, _currentLocation!.longitude);

        Placemark place = placemarks[0];

        setState(() {
          _currentAdress = "${place.subLocality},${place.administrativeArea}, ${place.country}";
        });
      }catch(e){
        if (kDebugMode) {
          print(e);
        }
      }
    }




  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Bulunduğunuz Noktanın Konumu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(
                'Latitude = ${_currentLocation?.latitude}; Longitude = ${_currentLocation?.longitude}'),
            SizedBox(
              height: 30,
            ),
            Text(
              'Bulunduğunuz Konumun Adresi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6,
            ),
            Text('${_currentAdress}'),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  _currentLocation = await _getCurrentLocation();
                  await _getAdressFromCoordinates();
                  
                  if (kDebugMode) {
                    print('${_currentLocation}');
                  }
                  if (kDebugMode) {
                    print('${_currentAdress}');
                  }
                },
                child: Text('Konumunu Öğren'))
          ],
        ),
      ),
    );
  }
}
