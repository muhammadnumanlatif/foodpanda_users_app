import 'package:flutter/material.dart';

import '../models/items.dart';

class CartItemDesign extends StatefulWidget {

final Items? model;
final BuildContext? context;
final int? quanNumber;

   CartItemDesign({super.key, this.model, this.quanNumber, this.context});
  @override
  State<CartItemDesign> createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyan,
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Container(
          height: 100,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Row(
            children: [
              Image.network(widget.model!.thumbnailUrl!,width:140,height: 120,),
              SizedBox(width:6,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.model!.title!,
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 16
                  ),
                  ),
                  SizedBox(height: 1,),
                  Row(
                    children: [
                      Text("x",
                        style:TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),
                      ),
                      Text(widget.quanNumber.toString(),
                        style:TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1,),
                  Row(
                    children: [
                      Text("Price:",
                        style:TextStyle(
                            color: Colors.grey,
                            fontSize: 16
                        ),
                      ),
                      Text("€ ",
                        style:TextStyle(
                            color: Colors.blue,
                            fontSize: 16
                        ),
                      ),
                      Text(widget.model!.price.toString(),
                        style:TextStyle(
                            color: Colors.blue,
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),


                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}