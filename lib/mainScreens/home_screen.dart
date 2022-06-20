import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodpanda_users_app/assistantMethods/assistant_methods.dart';
import 'package:foodpanda_users_app/models/sellers.dart';
import 'package:foodpanda_users_app/widgets/sellers_design.dart';
import 'package:foodpanda_users_app/widgets/my_drawer.dart';
import 'package:foodpanda_users_app/widgets/progress_bar.dart';

import '../authentication/auth_screen.dart';
import '../global/global.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items=[
    "slider/0.jpg",
    "slider/1.jpg",
    "slider/2.jpg",
    "slider/3.jpg",
    "slider/4.jpg",
    "slider/5.jpg",
    "slider/6.jpg",
    "slider/7.jpg",
    "slider/8.jpg",
    "slider/9.jpg",
    "slider/10.jpg",
    "slider/11.jpg",
    "slider/12.jpg",
    "slider/13.jpg",
    "slider/14.jpg",
    "slider/15.jpg",
    "slider/16.jpg",
    "slider/17.jpg",
    "slider/18.jpg",
    "slider/19.jpg",
    "slider/20.jpg",
    "slider/21.jpg",
    "slider/22.jpg",
    "slider/23.jpg",
    "slider/24.jpg",
    "slider/25.jpg",
    "slider/26.jpg",
    "slider/27.jpg",
  ];

  @override
  void initState() {
    clearCartNow(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan,
                Colors.amber,
              ],
              begin:FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops:[0.0,1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text("iFood"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      drawer: MyDrawer(),
      body:CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.30,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height*0.30,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 500),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                   // onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: items.map((index){
                    return Builder(builder: (BuildContext context){
               return Container(
                 width: MediaQuery.of(context).size.width,
                 margin: const EdgeInsets.symmetric(horizontal: 1),
                 decoration: const BoxDecoration(
                 color: Colors.black
                 ),
                 child: Padding(
                   padding: EdgeInsets.all(4.0),
                   child: Image.asset(index,
                   fit: BoxFit.fill,
                   ),
                 ),
               );
                    });
                  }).toList(),
                ),
              ),

            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("sellers").snapshots(),
            builder: (context,snapshot) {
              if (!snapshot.hasData) {
                return SliverToBoxAdapter(
                  child: Center(child: circularProgress(),),);
              } else {
                return SliverToBoxAdapter(
                  child: GridView.custom(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount:2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 2,
                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                      pattern: const [

                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 2),
                      ],
                    ),
                    
                    childrenDelegate: SliverChildBuilderDelegate(
                          (context, index) {
                           Sellers sModel = Sellers.fromJson(snapshot.data!.docs[index].data()! as Map<String,dynamic>);
                            return SellersDesignWidget(
                              model: sModel,
                              context: context,
                            );
                          },
                      childCount: snapshot.data!.docs.length,
                    ),
                  ),
                );
              }
            }),        ],
      ),
    );
  }
}
