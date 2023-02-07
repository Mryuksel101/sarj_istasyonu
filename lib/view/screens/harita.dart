


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../service/google_maps_api.dart';
import '../component/onerilen_sehirler.dart';
class Harita extends StatelessWidget {
  const Harita({Key? key}) : super(key: key);



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

  @override
  Widget build(BuildContext context) {
    debugPrint("harita yüklendi");
    return Scaffold(
      
      body: Stack(

        children: [

          
          GoogleMap(
            
            trafficEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: HaritalarApi.kLake,
            onMapCreated: (GoogleMapController controller) {
              HaritalarApi.controllerCopmplate(controller);
            },

           markers: isaretler(),
           
          
          ),

          const OnerilenSehirler(), 
        ],
      ),
      

    );
  }
}


