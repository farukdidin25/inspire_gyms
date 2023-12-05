import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:inspire_gyms/constants/api.dart';

import 'package:inspire_gyms/screens/gym_detail_page.dart';
import 'package:inspire_gyms/services/favorities_services.dart';
import 'package:inspire_gyms/services/gym_services.dart';
import 'package:inspire_gyms/services/location_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = Api.apiKey;
  late final GymService _gymService;
  late final LocationService _locationService;
  List<dynamic> gymList = [];
  List<dynamic> filteredGyms = [];

  @override
  void initState() {
    super.initState();
    _gymService = GymService(apiKey);
    _locationService = LocationService();
    _getLocationAndFetchGyms();
  }

  Future<void> _getLocationAndFetchGyms() async {
    try {
      Position position = await _locationService.getCurrentPosition();
      await _fetchNearbyGyms(position);
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
    }
  }

  Future<void> _fetchNearbyGyms(Position position) async {
    try {
      List<dynamic> nearbyGyms = await _gymService.fetchNearbyGyms(position);
      await _fetchGymDetails(nearbyGyms);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching nearby gyms: $e');
      }
    }
  }

  Future<void> _fetchGymDetails(List<dynamic> places) async {
    try {
      List<dynamic> newGymList = [];
      for (var place in places) {
        final placeId = place['place_id'];
        dynamic gymDetails = await _gymService.fetchGymDetails(placeId);
        newGymList.add(gymDetails);
      }
      if (mounted) {
        setState(() {
          gymList = newGymList;
          filteredGyms = newGymList;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching gym details: $e');
      }
    }
  }

  Widget _buildGymTile(dynamic gym) {
    return FutureBuilder<List<String>>(
      future: FavoritesService().getFavoriteGyms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            bool isFavorite = snapshot.data!.contains(gym['name']);

            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GymDetailPage(gym: gym),
                  ),
                );
              },
              title: Text(gym['name']),
              leading: gym['photoReference'] != ''
                  ? Image.network(
                      "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${gym['photoReference']}&key=$apiKey",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey,
                    ),
              trailing: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() {
                    if (isFavorite) {
                      FavoritesService().removeFavorite(gym);
                    } else {
                      FavoritesService().addFavorite(gym);
                    }
                  });
                },
              ),
            );
          }
        }
      },
    );
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
              onChanged: _updateFilteredGyms,
            ),
          ),
          Expanded(
            child: gymList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredGyms.length,
                    itemBuilder: (context, index) {
                      final gym = filteredGyms[index];
                      return _buildGymTile(
                          gym); // _buildGymTile widget'ı burada çağrılıyor
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _updateFilteredGyms(String query) {
    setState(() {
      filteredGyms = gymList
          .where(
              (gym) => gym['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
