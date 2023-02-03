import 'dart:async';
import 'dart:convert';
import 'dart:developer';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:sarj_istasyonu/main.dart';
class Harita extends StatefulWidget {
  const Harita({Key? key}) : super(key: key);

  @override
  State<Harita> createState() => _HaritaState();
}

class _HaritaState extends State<Harita> {

  double lat = 0;
  double long = 0;
  Map <String, dynamic> myMap = {};
  
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  

  void sehirTahmini(String inputx) async{ // yer tahminini ve onun idsi yer alıyor
    String baseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?";
    String apiKey = "AIzaSyCIKio0UF1xUXL_GvBhOCGV274SZUNNhos";
    String input = inputx;
    String components ="country:tr";
    String url = "${baseUrl}input=$input&key=$apiKey&components=$components";
    Response response = await get(Uri.parse(url));
    myMap = jsonDecode(response.body);

  }

  String yerId(int index){
    debugPrint("yer id");
    debugPrint(myMap ["predictions"][index]["place_id"].toString());
    return myMap["predictions"][index]["place_id"];
  }

  void latLongAl(int index) async{
    debugPrint("bura");
    String baseUrl = "https://maps.googleapis.com/maps/api/place/details/json?";
    String apiKey = "AIzaSyCIKio0UF1xUXL_GvBhOCGV274SZUNNhos";
    String place_id = yerId(index);
    String url = "${baseUrl}&key=$apiKey&place_id=$place_id";
    debugPrint("am");
    Response response = await get(Uri.parse(url));
    Map<String, dynamic> myMap2 = jsonDecode(response.body);
    
    lat = myMap2["result"]["geometry"]["location"]["lat"];
    long =  myMap2["result"]["geometry"]["location"]["lng"];

    log("secilen long: $long. seçilen lang: $lat");
  }

  Future<void> _search(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(
            lat,
            lng,
          ),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414
        )
      )
    );
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
            
            trafficEnabled: true,
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
              child: Column(
                
                children: [
                  CupertinoSearchTextField(
                    
                    onChanged: (value) {
                      debugPrint(value);
                      sehirTahmini(value);
                      debugPrint("değişti: $myMap");
                      setState(() {
                        
                      });
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
                    padding: EdgeInsets.all(10),
                    height: myMap.length * 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: myMap.length!=0? ListView.builder(
                      itemCount: myMap.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            debugPrint(myMap.toString());
                           debugPrint( myMap ["predictions"][index]["place_id"].toString());
                            latLongAl(index);
                            _search(lat,long);
                            debugPrint(index.toString());
                            
                          },
                          child: Text(
                            myMap["predictions"][index]["description"],
                            style: TextStyle(
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