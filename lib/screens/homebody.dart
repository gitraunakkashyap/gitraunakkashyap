import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:marquee/marquee.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';

class homebody extends StatelessWidget {
  final List<String> imageList = [
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpg',
    'assets/images/slider3.png',
  ];

  var data;

  // "https://www.setaswall.com/wp-content/uploads/2018/08/Spiderman-Wallpaper-76-1280x720.jpg",
  // "https://lh3.googleusercontent.com/proxy/yL2FmQfZA79S5eIDza9MH2NjKGIKWPOGRHxHdYwiNPcYDW26YmK6qnP01ZDLsBENZpiADc1ohkj3LzVjrwoX8Pb-crT6MYZb3Jp9gy3ZrlET_yvoFS0qtUHLq4DtVPcqIdxPiNWI_j08omBVACv-YJc",
  // "https://images.hdqwalls.com/download/spiderman-peter-parker-standing-on-a-rooftop-ix-1280x720.jpg",
  // "https://images.wallpapersden.com/image/download/peter-parker-spider-man-homecoming_bGhsa22UmZqaraWkpJRmZ21lrWxnZQ.jpg",
  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvUgui-suS8DgaljlONNuhy4vPUsC_UKvxJQ&usqp=CAU",

  // new Image(image:  AssetImage('assets/images/logo2.png')),

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Container(
          child: CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              autoPlay: true,
            ),
            items: imageList
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                      margin: EdgeInsets.only(
                        top: 10.0,
                        bottom: 20.0,
                      ),
                      // enlargeCenterPage: true,
                      // elevation: 3.0,
                      shadowColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0.0),
                        ),
                        child: Image.asset(
                          item,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        new Row(
         mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            new Text(
              "Featured",
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20.0, color: Colors.lightBlue),
            ),
            new Icon(Icons.arrow_back_ios),
            new Icon(Icons.arrow_forward_ios)
          ],
        ), new Container(
            // FeaturedProduct(title: '',)
        ),
        // new Container(child: _buildMarquee(),
        // ),
      ],
    );


  }



  Widget _buildMarquee() {
    return Marquee(
      text: 'Free delivery on orders over Rs. 500',
      style: TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 150.0,
      velocity: 60.0,
      // pauseAfterRound: Duration(seconds: 1),
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      numberOfRounds: 100,
      startPadding: 10.0,
      accelerationDuration: Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
      textDirection: TextDirection.ltr,
    );
  }


}

class FeaturedProduct extends StatefulWidget{
  FeaturedProduct({Key? key, required this.title}) : super(key:key);
  final String title;
  @override
  State<StatefulWidget> createState() {
     throw UnimplementedError();
  }
}

class FeaturedProductData {

  final String fpName;
  final String fpImage;
  final String fpWeight;
  final String fpDiscount;
  final String fpActamount;
  final String fpDisAmount;

  FeaturedProductData(this.fpName, this.fpImage, this.fpWeight, this.fpDiscount, this.fpActamount, this.fpDisAmount);

}
