import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http; 
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = 'AIzaSyAkz8HaFrmjTwIiDxey04Lnrn0C5bIi8iU';
  final String endpoint =
      'https://places.googleapis.com/v1/places:searchNearby';

  List<String> gymList = [];

  String _searchQuery = '';

  List<String> get filteredGyms {
    return gymList.where((gym) {
      return gym.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    fetchNearbyGyms().then((gyms) {
      setState(() {
        gymList = gyms;
      });
    }).catchError((error) {});
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<String>> fetchNearbyGyms() async {
    Position position = await _determinePosition();
    final double latitude = position.latitude;
    final double longitude = position.longitude;
    final String requestUrl = '$endpoint?key=$apiKey';
    final Map<String, dynamic> requestData = {
      "includedTypes": ["gym"],
      "locationRestriction": {
        "circle": {
          "center": {"latitude": latitude, "longitude": longitude},
          "radius": 2000.0
        }
      }
    };

    final response = await http.post(
      Uri.parse(requestUrl),
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': apiKey,
        'X-Goog-FieldMask': 'places.displayName'
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<String> gymNames = [];

      for (var place in jsonData['places']) {
        gymNames.add(place['displayName']['text']);
      }

      return gymNames;
    } else {
      throw Exception('Failed to load gyms');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredGyms.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                    ),
                    title: Text(filteredGyms[index]),
                    // Buraya gerekirse diğer bilgileri ekleyebilirsiniz.
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


