
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodpanda_users_app/widgets/app_bar.dart';

import '../global/global.dart';
import '../models/items.dart';
import '../models/menus.dart';
import '../widgets/items_design.dart';
import '../widgets/sellers_design.dart';
import '../widgets/my_drawer.dart';
import '../widgets/progress_bar.dart';
import '../widgets/text_widget_header.dart';

class ItemsScreen extends StatefulWidget {
   ItemsScreen({Key? key, required this.model}) : super(key: key);
final Menus model;
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: MyAppBar(sellerUID:widget.model.sellerUID),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title:"Items of ${ widget.model.menuTitle}")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("sellers").doc(widget.model.sellerUID).collection("menus").doc(widget.model.menuID).collection("items").orderBy("publishedDate",descending: true).snapshots(),
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
                      Items sModel = Items.fromJson(snapshot.data!.docs[index].data()! as Map<String,dynamic>);
                      return ItemsDesignWidget(
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
