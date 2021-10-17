import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tampilkoordinat/destinasi.dart';
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

  List<Destinasi> destinasi = [
    Destinasi(1, 0, -6.9024812, 107.6166213, 'Gedung Sate'),
    Destinasi(1, 0, -6.9218571, 107.6048254, 'Alun-Alun Bandung')
  ];

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
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: destinasi.length,
                    itemBuilder: (context, int) {
                      destinasi.sort((a, b) {
                        return a.jarak.compareTo(b);
                      });
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  destinasi[int].name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  destinasi[int].jarak = Haversine.haversine(
                                          lat1,
                                          long1,
                                          destinasi[int].latitude,
                                          destinasi[int].longitude)
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    })
              ],
            ),
          )
        ]));
  }
}
