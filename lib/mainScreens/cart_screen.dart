import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_users_app/assistantMethods/total_amount.dart';
import 'package:foodpanda_users_app/mainScreens/address_screen.dart';
import 'package:foodpanda_users_app/widgets/app_bar.dart';
import 'package:foodpanda_users_app/widgets/cart_item_design.dart';
import 'package:foodpanda_users_app/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/assistant_methods.dart';
import '../assistantMethods/cart_item_counter.dart';
import '../models/items.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/text_widget_header.dart';

class CartScreen extends StatefulWidget {
  final String? sellerUID;

  CartScreen({super.key, this.sellerUID});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? separateItemQuantityList;
num totalAmount=0;
  @override
  void initState() {
    separateItemQuantityList = separateItemQuantities();
    totalAmount=0;
    Provider.of<TotalAmount>(context,listen: false).displayTotalAmount(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              clearCartNow(context);
            },
            icon: Icon(Icons.clear_all)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan,
                Colors.amber,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text("iFood"),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {

                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.cyan,
                  )),
              Positioned(
                  child: Stack(
                children: [
                  Icon(
                    Icons.brightness_1,
                    size: 20,
                    color: Colors.green,
                  ),
                  Positioned(
                    top: 3,
                    right: 4,
                    child: Center(
                      child: Consumer<CartItemCounter>(
                          builder: (context, counter, c) {
                        return Text(counter.count.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12));
                      }),
                    ),
                  )
                ],
              ))
            ],
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 10,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              onPressed: () {
                clearCartNow(context);
                Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen()));
                Fluttertoast.showToast(msg: "Cart has been cleared");
              },
              label: Text("Clear Cart"),
              backgroundColor: Colors.cyan,
              icon: Icon(Icons.clear_all),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (c)=>AddressScreen(
                  totalAmount: totalAmount.toDouble(),
                  sellerUID: widget.sellerUID!,

                )));
              },
              label: Text("Check out"),
              backgroundColor: Colors.cyan,
              icon: Icon(Icons.navigate_next),
            ),
          )
        ],
      ),
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(
            pinned: true,
            delegate: TextWidgetHeader(title: "My Cart List")),
        SliverToBoxAdapter(
          child: Consumer2<TotalAmount,CartItemCounter>(builder: (context,amountProvider,cartProvider,c){
            return Padding(
                padding: EdgeInsets.all(8),
              child: Center(
                child: cartProvider.count==0?Container():Text("Total Price: ${amountProvider.tAmount.toString()}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                ),
              ),
            
            );
          }),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("items")
              .where("itemID", whereIn: separateItemIDs())
              .orderBy("publishedDate", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData

                ? SliverToBoxAdapter(child: Center(child: circularProgress()))
                : snapshot.data!.docs.length == 0
                    ? Container()
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          Items model = Items.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);

                          if(index==0){
                          totalAmount=0;
                          totalAmount= totalAmount + (model.price! * separateItemQuantityList![index]);
                          }else{
                            totalAmount= totalAmount + (model.price! * separateItemQuantityList![index]);
                          }
if(snapshot.data!.docs.length-1==index){
  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(totalAmount.toDouble());
  });
}
                          return CartItemDesign(
                            model: model,
                            context: context,
                            quanNumber: separateItemQuantityList![index],
                          );
                        },
                            childCount: snapshot.hasData
                                ? snapshot.data!.docs.length
                                : 0),
                      );
          },
        )
      ]),
    );
  }
}
