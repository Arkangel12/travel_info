import 'dart:async';

import 'package:demo_meetup/src/api/apiCalls.dart';
import 'package:demo_meetup/src/models/country.dart';
import 'package:demo_meetup/src/screens/detailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiCalls apiCalls = ApiCalls();
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _CDMX = CameraPosition(
    target: LatLng(19.4288169, -99.14961053600166),
    zoom: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Country>>(
        future: apiCalls.getCountries(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
          return GoogleMap(
            initialCameraPosition: _CDMX,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              for(Country country in snapshot.data)
                if(country.latlng.length > 0)
                  Marker(
                  markerId: MarkerId(country.name),
                  onTap: () => Navigator.of(context).push(DetailsScreen.route(country)),
                  position: LatLng(country.latlng[0],country.latlng[1],
                  )
                ),
            },
            myLocationButtonEnabled: false,
          );
        },
      ),
    );
  }
}
