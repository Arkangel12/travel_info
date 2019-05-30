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
  double _screenHeight;
  double _bottomSize = 60;
  double _defaultBottomSize = 60;
  List details = [];
  String translate = '';

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _CDMX = CameraPosition(
    target: LatLng(19.4288169, -99.14961053600166),
    zoom: 4,
  );

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FutureBuilder<List<Country>>(
            future: apiCalls.getCountries(),
            initialData: [],
            builder: (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              } else {
              return GoogleMap(
                initialCameraPosition: _CDMX,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onTap: (_) => setState(()=> _bottomSize = _defaultBottomSize),
                markers: {
                  for (Country country in snapshot.data)
                    if (country.latlng.length > 0)
                      Marker(
                        markerId: MarkerId(country.name),
                        onTap: () {
                          setState(() {
                            details.clear();
                            _bottomSize = _screenHeight * .6;
//                            getDetails(country);
                            details.add(DetailsScreen(country: country));
                          });
                        },
                        position: LatLng(
                          country.latlng[0],
                          country.latlng[1],
                        ),
                      ),
                },
                myLocationButtonEnabled: false,
              );
              }
            },
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (val) {
                setState(() => _bottomSize = _screenHeight - val.globalPosition.dy);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: MediaQuery.of(context).size.width,
                height: _bottomSize,
                constraints: BoxConstraints(
                    minHeight: _defaultBottomSize,
                    maxHeight: _screenHeight * 0.85,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 5,
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[200],
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        ...details,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
