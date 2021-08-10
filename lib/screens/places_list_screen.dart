import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:great_places_app/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatefulWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  Future? greatPlacesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: greatPlacesFuture,
        builder: (_, dataSnapshot) => dataSnapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text('You have no places added, add some!'),
                ),
                builder: (_, places, ch) => places.items.length <= 0
                    ? ch!
                    : ListView.builder(
                        itemCount: places.items.length,
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(places.items[index].image),
                          ),
                          title: Text(places.items[index].title),
                          subtitle: Text(places.items[index].location.toString()),
                          onTap: () => Navigator.of(ctx).pushNamed(
                            PlaceDetailsScreen.routeName,
                            arguments: places.items[index].id,
                          ),
                        ),
                      ),
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    greatPlacesFuture = Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces();
  }
}
