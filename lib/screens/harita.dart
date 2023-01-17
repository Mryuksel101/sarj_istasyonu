import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Harita extends StatefulWidget {
  const Harita({Key? key}) : super(key: key);

  @override
  State<Harita> createState() => _HaritaState();
}

class _HaritaState extends State<Harita> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("init");
  }
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414
  );

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  @override
  Widget build(BuildContext context) {
    debugPrint("harita yüklendi");
    return Scaffold(
      
      body: Stack(

        children: [

          
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kLake,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
      
          
          ),

          SafeArea(
            child: Padding(
              
              padding: const EdgeInsets.all(8.0),
              child: CupertinoTextField(
                placeholder: "Ara...",
                prefix: Icon(
                  CupertinoIcons.search,
                  color: CupertinoColors.systemGrey,
                ),
                
              ),
            ),
          )
        ],
      ),
      

    );
  }
}