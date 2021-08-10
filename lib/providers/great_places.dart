import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/helpers/db_helper.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String pickedTitle, File pickedImage, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: pickedTitle,
      image: pickedImage,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location?.latitude ?? 0.0,
      'loc_lng': newPlace.location?.longitude ?? 0.0,
      'address': newPlace.location?.address ?? '',
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final List<Map<String, dynamic>> fetchedPlaces = await DBHelper.getData('user_places');

    /// This is a bad approach, because the _items list will not be refreshed on fetch, it will grow with
    /// everymethod call!!!
    ///
    // fetchedPlaces.forEach((el) {
    //   _items.insert(0, Place(
    //     id: el['id'],
    //     title: el['title'],
    //     image: File(el['image']),
    //     location: null
    //   ));
    // });
    _items = fetchedPlaces
        .map((el) => Place(
              id: el['id'],
              title: el['title'],
              image: File(el['image']),
              location: PlaceLocation(latitude: el['loc_lat'], longitude: el['loc_lng'], address: el['address']),
            ))
        .toList();
    notifyListeners();
  }

  Place findById(id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
