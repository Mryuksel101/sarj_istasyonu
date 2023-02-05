


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../service/google_maps_api.dart';
class Harita extends StatefulWidget {
  const Harita({Key? key}) : super(key: key);

  @override
  State<Harita> createState() => _HaritaState();
}

class _HaritaState extends State<Harita> {

  void initState() {
    // TODO: implement initState
    super.initState();
  }

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

          SafeArea(
            child: Padding(
              
              padding: const EdgeInsets.all(8.0),
              child: Column(
                
                children: [
                  CupertinoSearchTextField(
                    
                    onChanged: (value) {
                      if(value.isNotEmpty){
                        HaritalarApi.sehirTahmini(value);
                        setState(() {
                        
                        });
                      }
                      
                      
                    },
                
                    placeholder: "Ara...",
                    prefixInsets: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    
                  ),

                  
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.all(10),
                    height: HaritalarApi.myMap.length * 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: HaritalarApi.myMap.isNotEmpty? ListView.builder(
                      itemCount: HaritalarApi.myMap.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            debugPrint("kanka $index");
                           debugPrint( HaritalarApi.myMap ["predictions"][index]["place_id"].toString());
                            HaritalarApi.latLongAl(index);
                            HaritalarApi.search(HaritalarApi.lat,HaritalarApi.long);
                            debugPrint(index.toString());
                            
                          },
                          child: Text(
                            HaritalarApi.myMap["predictions"][index]["description"],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          )
                        );
                      },
                    ):const SizedBox(),
                  ),

                  
                  
                ],
              ),
            ),
          ),  
        ],
      ),
      

    );
  }
}