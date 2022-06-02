import 'package:flutter/material.dart';
import 'package:weather_app/CuacaLain/CuacaTambahan.dart';
import 'package:weather_app/Data/dataset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weather_app/SettingPage.dart';

class HalamanDetail extends StatelessWidget {
  Weather cuacaBesok;
  final List<Weather> sevenDay;
  HalamanDetail(this.cuacaBesok,this.sevenDay);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: Column(
        children: [CuacaBesok(cuacaBesok), Seminggu(sevenDay)],
      ),
    );
  }
}

class CuacaBesok extends StatelessWidget {
  final Weather cuacaBesok;
  CuacaBesok(this.cuacaBesok);
  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      color: Color(0XFF5C6BC0),
      glowColor: Color(0XFF5C6BC0),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    Text(
                      " 7 Hari Kedepan",
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context){
                          return ScreenProfile();
                        }),
                      );
                    },
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(cuacaBesok.image))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Besok",
                      style: TextStyle(fontSize: 25, height: 0.1),
                    ),
                    Container(
                      height: 105,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GlowText(
                            cuacaBesok.max.toString(),
                            style: TextStyle(
                                fontSize: 100, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "/" + cuacaBesok.min.toString() + "\u00B0",
                            style: TextStyle(
                                color: Colors.black54.withOpacity(0.3),
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        " "
                    ),
                    Text(
                      cuacaBesok.name,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              right: 50,
              left: 50,
            ),
            child: Column(
              children: [
                Divider(color: Colors.white),
                SizedBox(
                  height: 10,
                ),
                Cuaca_Tambahan(cuacaBesok)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Seminggu extends StatelessWidget {
  List<Weather> sevenDay;
  Seminggu(this.sevenDay);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: sevenDay.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.only(top: 15,left: 20, right: 20, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(sevenDay[index].day, style: TextStyle(fontSize: 20)),
                    Container(
                      width: 135,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            image: AssetImage(sevenDay[index].image),
                            width: 40,
                          ),
                          SizedBox(width: 15),
                          Text(
                            sevenDay[index].name,
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "+" + sevenDay[index].max.toString() + "\u00B0",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "+" + sevenDay[index].min.toString() + "\u00B0",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ));
          }),
    );
  }
}
