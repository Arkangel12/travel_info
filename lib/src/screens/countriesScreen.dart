import 'package:demo_meetup/src/api/apiCalls.dart';
import 'package:demo_meetup/src/models/country.dart';
import 'package:demo_meetup/src/screens/detailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiCalls apiCalls = ApiCalls();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Country>>(
        future: apiCalls.getCountries(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Country country = snapshot.data[index];
                return ListTile(
                  onTap: ()=> Navigator.of(context).push(DetailsScreen.route(country)),
                  trailing: SizedBox(width: 50, height: 50,child: SvgPicture.network(country.flag)),
                  title: Text(country.name),
                  subtitle: Text(country.capital),
                );
              });
        },
      ),
    );
  }
}
