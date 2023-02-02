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

  

  Set<Marker> isaretler(){
    return <Marker>{
       Marker(
        markerId: const MarkerId("ilk"),
        position: const LatLng(
          36.477638,
          36.454552,
        ),

        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),

      Marker(
        markerId: const MarkerId("iki"),
        position: const LatLng(
          36.477638,
          36.454999,
        ),

        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),

      Marker(
        markerId: const MarkerId("uc"),
        position: const LatLng(
          36.477999,
          36.454999,
        ),

        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    };
  }

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(
      36.477638,
      36.454552,
    ),
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

           markers: isaretler(),
           
          
          ),

          SafeArea(
            child: Padding(
              
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                placeholder: "Ara...",
                prefixInsets: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                
              ),
            ),
          )
        ],
      ),
      

    );
  }
}