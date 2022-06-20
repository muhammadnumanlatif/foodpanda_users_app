import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_users_app/widgets/app_bar.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../assistantMethods/assistant_methods.dart';
import '../models/items.dart';

class ItemDetailScreen extends StatefulWidget {
   ItemDetailScreen({Key? key, this.model}) : super(key: key);
final Items? model;
  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  TextEditingController counterTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: MyAppBar(sellerUID:widget.model!.sellerUID!),

      body: Column(
        children: [
          Image.network(widget.model!.thumbnailUrl!),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: NumberInputPrefabbed.roundedButtons(controller:counterTextEditingController ,
            incDecBgColor: Colors.amber,

              min:1,
                max:9,
              initialValue: 1,
              buttonArrangement: ButtonArrangement.incLeftDecRight,

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.model!.title!,
            style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 20
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.model!.longDescription!,
              style: TextStyle(
                  fontWeight: FontWeight.normal,fontSize: 14
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("€ "+widget.model!.price!.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 30
              ),
            ),
          ),
          InkWell(
            onTap: (){
              int itemCounter = int.parse(counterTextEditingController.text);
              //1.check if item exist  in cart
              List<String> separateItemIDsList = separateItemIDs();
              separateItemIDsList.contains(widget.model!.itemID)
              ?Fluttertoast.showToast(msg: "Already in cart")
              :
              //2.adc to cart
                addItemToCart(widget.model!.itemID!,context, itemCounter);
            },
          child: Container(
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
            height: 50,
            width: MediaQuery.of(context).size.width-40,
            child:Center(
              child: Text("Add to Cart",
              style: TextStyle(color: Colors.white),

              ),
            ),
          ),
          )
        ],
      ),
    );
  }
}
