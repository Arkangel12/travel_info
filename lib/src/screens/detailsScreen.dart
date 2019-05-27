import 'package:demo_meetup/src/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatefulWidget {
  final Country country;

  const DetailsScreen({Key key, this.country}) : super(key: key);

  static Route<dynamic> route(country) {
    return MaterialPageRoute(
      builder: (context) => DetailsScreen(country: country),
    );
  }

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String translate = '';

  @override
  Widget build(BuildContext context) {
    Country country = widget.country;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country.name),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: SvgPicture.network(country.flag),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(20),
              width: width,
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
                    width: width,
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
            ),
          )
        ],
      ),
    );
  }

  Widget centerInColumn({String category, String value, TextStyle style}) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '$category: $value',
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
}
