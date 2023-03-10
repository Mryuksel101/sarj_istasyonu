import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class HaritalarApi{
  static Map myMap = {};


  
  static Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  
  static Future<void> search(double lat, double lng) async {
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



  static Future<Map> sehirTahmini(String inputx) async{ // response'da yer tahminini ve onun idsi yer alıyor
    String baseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?";
    String apiKey = "AIzaSyCIKio0UF1xUXL_GvBhOCGV274SZUNNhos";
    String input = inputx;
    String components ="country:tr";
    String url = "${baseUrl}input=$input&key=$apiKey&components=$components";
    Response response = await get(Uri.parse(url));
    myMap = jsonDecode(response.body);
    return myMap;

    
  }

  static String yerId(int index){
    //debugPrint("yer id");
    //debugPrint(myMap ["predictions"][index]["place_id"].toString());
    return myMap["predictions"][index]["place_id"];
  }

  static void latLongAl(int index) async{
    String baseUrl = "https://maps.googleapis.com/maps/api/place/details/json?";
    String apiKey = "AIzaSyCIKio0UF1xUXL_GvBhOCGV274SZUNNhos";
    String place_id = yerId(index);
    String url = "$baseUrl&key=$apiKey&place_id=$place_id";

    Response response = await get(Uri.parse(url));
    Map<String, dynamic> myMap2 = jsonDecode(response.body);

    
    
    double lat = myMap2["result"]["geometry"]["location"]["lat"];
    double long =  myMap2["result"]["geometry"]["location"]["lng"];

    
    HaritalarApi.search(lat,long);
  }

  static void controllerCopmplate(var c){
    _controller.complete(c);
  }

  static Future<void> goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(kLake));
  }

  static const CameraPosition kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(
      36.477638,
      36.454552,
    ),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414
  );
}