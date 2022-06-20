import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/assistantMethods/cart_item_counter.dart';
import 'package:foodpanda_users_app/authentication/auth_screen.dart';
import 'package:foodpanda_users_app/mainScreens/cart_screen.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  final String? sellerUID;
  MyAppBar({Key? key, this.bottom, required this.sellerUID}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:Icon(Icons.arrow_back)),
      flexibleSpace: Container(
        decoration:  BoxDecoration(
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
                  //send user to cart screen

                  Navigator.push(context, MaterialPageRoute(builder: (c)=>CartScreen(sellerUID: widget.sellerUID)));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.cyan,
                )),
            Positioned(
                child: Stack(
              children:  [
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
                        builder: (context,counter,c){
                      return Text(
                        counter.count.toString(),
                        style:TextStyle(
                          color: Colors.white,
                          fontSize: 12
                      )
                      );
                    }
                    ),
                  ),
                )
              ],
            ))
          ],
        )
      ],
    );
  }


}
