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
                            _bottomSize = _screenHeight * .55;
                            getDetails(country);
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
                      topRight: Radius.circular(
                        (25),
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 5,
                          margin: EdgeInsets.symmetric(vertical: 10),
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

  getDetails(Country country) {
    String translate = '';

    Widget centerInColumn({String category, String value, TextStyle style}) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          category != null ? '$category: $value': '$value',
          style: style,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    Widget doTranslate({String translation, String to}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: InkWell(
          onTap: () => setState(() => translate = translation),
          child: Chip(
            label: Text(to),
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
      );
    }

    details.add(Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        centerInColumn(value: country.name, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
        Container(
          width: 100,
          height: 100,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(vertical: 5),
          child: SvgPicture.network(country.flag),
        ),
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              centerInColumn(
                category: 'Capital',
                value: country.capital,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              centerInColumn(
                  category: 'Nombre Nativo', value: country.nativeName),
              Text(
                  'Moneda: ${country.currencies[0].name} (${country.currencies[0].symbol})'),
              Text('Población: ${country.population.toString()}'),
              Text(
                  'Codigo de llamada: ${country.callingCodes[0].toString()}'),
              centerInColumn(category: 'Fronteras', value: ''),
              Wrap(
                children: <Widget>[
                  for (String border in country.borders)
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(border),
                    ),
                ],
              ),
              Text('Lenguaje: ${country.languages[0].name}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Traduccir: '),
                  Text(
                    translate,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  children: <Widget>[
                    doTranslate(
                        translation: country.translations.de, to: 'De'),
                    doTranslate(
                        translation: country.translations.es, to: 'Es'),
                    doTranslate(
                        translation: country.translations.fr, to: 'Fr'),
                    doTranslate(
                        translation: country.translations.ja, to: 'Ja'),
                    doTranslate(
                        translation: country.translations.it, to: 'It'),
                    doTranslate(
                        translation: country.translations.br, to: 'Br'),
                    doTranslate(
                        translation: country.translations.pt, to: 'Pt'),
                    doTranslate(
                        translation: country.translations.nl, to: 'Nl'),
                    doTranslate(
                        translation: country.translations.hr, to: 'Hr'),
                    doTranslate(
                        translation: country.translations.fa, to: 'Fa'),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));

    setState(() {});
//    return Column(
//      children: <Widget>[
//        Expanded(
//          flex: 1,
//          child: Container(
//            padding: EdgeInsets.symmetric(vertical: 5),
//            child: SvgPicture.network(country.flag),
//          ),
//        ),
//        Expanded(
//          flex: 2,
//          child: Container(
//            padding: EdgeInsets.all(20),
//            width: double.infinity,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: <Widget>[
//                centerInColumn(
//                  category: 'Capital',
//                  value: country.capital,
//                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                ),
//                centerInColumn(
//                    category: 'Nombre Nativo', value: country.nativeName),
//                Text(
//                    'Moneda: ${country.currencies[0].name} (${country.currencies[0].symbol})'),
//                Text('Población: ${country.population.toString()}'),
//                Text(
//                    'Codigo de llamada: ${country.callingCodes[0].toString()}'),
//                centerInColumn(category: 'Fronteras', value: ''),
//                Wrap(
//                  children: <Widget>[
//                    for (String border in country.borders)
//                      Container(
//                        padding: EdgeInsets.all(8),
//                        margin: EdgeInsets.all(5),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(30)),
//                          border: Border.all(color: Colors.black),
//                        ),
//                        child: Text(border),
//                      ),
//                  ],
//                ),
//                Text('Lenguaje: ${country.languages[0].name}'),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  children: <Widget>[
//                    Text('Traduccir: '),
//                    Text(
//                      translate,
//                      style: TextStyle(
//                          fontSize: 16, fontWeight: FontWeight.bold),
//                      overflow: TextOverflow.ellipsis,
//                    ),
//                  ],
//                ),
//                Container(
//                  width: double.infinity,
//                  child: Wrap(
//                    children: <Widget>[
//                      doTranslate(
//                          translation: country.translations.de, to: 'De'),
//                      doTranslate(
//                          translation: country.translations.es, to: 'Es'),
//                      doTranslate(
//                          translation: country.translations.fr, to: 'Fr'),
//                      doTranslate(
//                          translation: country.translations.ja, to: 'Ja'),
//                      doTranslate(
//                          translation: country.translations.it, to: 'It'),
//                      doTranslate(
//                          translation: country.translations.br, to: 'Br'),
//                      doTranslate(
//                          translation: country.translations.pt, to: 'Pt'),
//                      doTranslate(
//                          translation: country.translations.nl, to: 'Nl'),
//                      doTranslate(
//                          translation: country.translations.hr, to: 'Hr'),
//                      doTranslate(
//                          translation: country.translations.fa, to: 'Fa'),
//                    ],
//                  ),
//                ),
//              ],
//            ),
//          ),
//        )
//      ],
//    );
  }
}
