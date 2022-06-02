import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weather_app/Data/dataset.dart';
import 'package:weather_app/CuacaLain/CuacaTambahan.dart';
import 'package:weather_app/detail/DetailCuaca.dart';

Weather currentTemp;
Weather cuacaBesok;
List<Weather> cuacaHariini;
List<Weather> sevenDay;

//Settingan awal
String lat = "-7.797068";
String lon = "110.370529";
String city = "Yogyakarta";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  getData() async{
    fetchData(lat, lon, city).then((value){
      currentTemp = value[0];
      cuacaHariini = value[1];
      cuacaBesok = value[2];
      sevenDay = value[3];
      setState(() {
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: currentTemp==null ? Center(child: CircularProgressIndicator(),):Column(
        children: [CuacaSekarang(getData), CuacaHariIni()],
      ),
    );
  }
}

class CuacaHariIni extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50,right: 50,top: 20),
      child: Column(children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, 
                MaterialPageRoute(builder: (BuildContext context){
                return HalamanDetail(cuacaBesok,sevenDay);
                }),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(
              "Hari Ini",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                    "7 Hari",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),Icon(Icons.arrow_forward_ios_outlined,
                  color: Colors.grey,
                  size: 10,
                ),
              ],
            ),
          ],
          ),
        ),
        SizedBox(
            height: 10
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              WeatherWidget(cuacaHariini[0]),
              WeatherWidget(cuacaHariini[1]),
              WeatherWidget(cuacaHariini[2]),
              WeatherWidget(cuacaHariini[3]),
            ],
          ),
        ),
      ],
      ),
    );
  }
}

class CuacaSekarang extends StatefulWidget {

  final Function() updateData;
  CuacaSekarang(this.updateData);
  @override
  State<CuacaSekarang> createState() => _CuacaSekarangState();
}

class _CuacaSekarangState extends State<CuacaSekarang> {

  bool BagCari = false;
  bool updating = false;
  var focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          if(BagCari)
            setState(() {
              BagCari = false;
            });
        },
      child: GlowContainer(
        height: MediaQuery.of(context).size.height-230,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.only(top: 30, left: 30, right: 30),
        glowColor: Color(0XFF5C6BC0).withOpacity(0.5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60)
        ),
        color: Color(0XFF5C6BC0),
        spreadRadius: 5,
        child: Column(
          children: [
            Container(
              child: BagCari?
              TextField(
                focusNode: focusNode,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    fillColor: Color(0xff030317),
                    filled: true,
                    hintText:"Masukkan Nama Kota",
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value)async{
                  CityModel temp = await fetchCity(value);
                  if(temp==null){
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        backgroundColor: Color(0xff343457),
                        title:Text("Kota Tidak Ditemukan"),
                        content: Text("Cek Kembali Nama Kota"),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child: Text("Ok"))
                        ],
                      );
                    });
                    BagCari = false;
                    return;
                  }
                  city = temp.name;
                  lat = temp.lat;
                  lon = temp.lon;
                  updating = true;
                  setState(() {

                  });
                  widget.updateData();
                  BagCari = false;
                  updating = false;
                  setState(() {
                  });
                },
              )
              :Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Icon(
                  CupertinoIcons.square_grid_2x2,
                  color: Colors.white,
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.map_fill,color: Colors.white),
                    Text(
                        " "
                    ),
                    GestureDetector(
                      onTap: (){
                        BagCari = true;
                        setState(() {

                        });
                        focusNode.requestFocus();
                      },
                      child: Text(
                        city,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                  Icon(
                    Icons.more_vert, color: Colors.white,
                  ),
              ],),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(width: 0.2, color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                updating?"Updating":"Updated",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 300,
                child: Stack(
                  children: [
                    Image(
                    image: AssetImage(currentTemp.image),
                    height: 235, width: 235,
                    ),
                    Positioned(bottom: 0, right: 0, left: 0,
                        child: Center(
                          child: Expanded(
                            child: Column(
                              children: [
                                GlowText(currentTemp.current.toString()+ "°C",
                                style:
                                TextStyle(overflow: TextOverflow.ellipsis,
                                  height: 0.05,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold
                                ),
                                ),
                                Text(currentTemp.name,
                                style: TextStyle(
                                    height: 2,
                                  fontSize: 20,
                                ),),
                                Text(currentTemp.day,
                                style: TextStyle(color: Colors.white,
                                  height: 1,
                                  fontSize: 13,
                                ),),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.white,),
            SizedBox(height: 10,),
            Cuaca_Tambahan(currentTemp),
          ],
        ),
      ),
    );
  }
}


class WeatherWidget extends StatelessWidget {

  final Weather weather;
  WeatherWidget(this.weather);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(width: 0.2, color: Colors.white),
        borderRadius: BorderRadius.circular(35)
      ),
      child: Column(
        children: [
          Text(
            weather.current.toString()+"\u00B0",
            style: TextStyle(fontSize: 20)
          ),
          SizedBox(height: 5,
          ),
          Image(
            image: AssetImage(weather.image),
            width: 50,
            height: 50,
          ),
          Text(
            weather.time,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          )
        ],
      ),
    );
  }
}


