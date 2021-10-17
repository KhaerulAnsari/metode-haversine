import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tampilkoordinat/haversine_base.dart';
import 'package:tampilkoordinat/location_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LocationService locationService = LocationService();
  Haversine haversine;

  double lat1 = 0;
  double long1 = 0;
  double lati2;
  double longi2;
  double lat2;
  double long2;
  double hasil;

  @override
  void initState() {
    super.initState();
    locationService.locationStream.listen((userLocation) {
      setState(() {
        lat1 = userLocation.latitude;
        long1 = userLocation.longitude;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[400],
        appBar: AppBar(
          title: Text('Realtime Koordinat Users'),
        ),
        body: ListView(children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dari Posisi Anda'),
                Text('Latitude'),
                Text(
                  '$lat1',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Longitude'),
                Text(
                  '$long1',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                    child: Text('Simpan'),
                    onPressed: () {
                      setState(() {
                        lati2 = lat1;
                        return lati2;
                      });
                      setState(() {
                        longi2 = long1;
                        return longi2;
                      });
                    }),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.grey,
                  ),
                  child: Text('Hasil'),
                  onPressed: () {
                    setState(() {
                      hasil = Haversine.haversine(lat1, long1, lati2, longi2);
                    });
                  },
                ),
                Column(children: <Widget>[Text('$hasil')])
              ],
            ),
          )
        ]));
  }
}
