
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_users_app/models/sellers.dart';

import '../assistantMethods/assistant_methods.dart';
import '../global/global.dart';
import '../models/menus.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/menus_design.dart';
import '../widgets/sellers_design.dart';
import '../widgets/my_drawer.dart';
import '../widgets/progress_bar.dart';
import '../widgets/text_widget_header.dart';

class MenusScreen extends StatefulWidget {
  MenusScreen({Key? key, required this.model}) : super(key: key);
final Sellers model;
  @override
  _MenusScreenState createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
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
        leading: IconButton(
            onPressed: () {
              clearCartNow(context);
              Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen()));
              Fluttertoast.showToast(msg: "Cart has been cleared");
            },
            icon: Icon(Icons.arrow_back)),
        title: Text("iFood"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title:widget.model.sellerName.toString()+ " Menus")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("sellers").doc(widget.model.sellerUID).collection("menus").orderBy("publishedDate",descending: true).snapshots(),
            builder: (context, snapshot){
              return !snapshot.hasData
                  ?SliverToBoxAdapter(
                child: Center(child: circularProgress()),
              )
                  : SliverToBoxAdapter(
                child: GridView.custom(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount:2,
                    mainAxisSpacing: 2,
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
                      Menus sModel = Menus.fromJson(snapshot.data!.docs[index].data()! as Map<String,dynamic>);
                      return MenusDesignWidget(
                        model: sModel,
                        context: context,
                      );
                    },
                    childCount: snapshot.data!.docs.length,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
