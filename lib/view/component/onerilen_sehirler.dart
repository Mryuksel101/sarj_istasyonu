import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../service/google_maps_api.dart';

class OnerilenSehirler extends StatefulWidget {
  const OnerilenSehirler({super.key});

  @override
  State<OnerilenSehirler> createState() => _OnerilenSehirlerState();
}

class _OnerilenSehirlerState extends State<OnerilenSehirler> {
  @override
  Widget build(BuildContext context) {
    debugPrint("OnerilenSehirler buildi");
    return SafeArea(
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
              child: ListView.builder(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}