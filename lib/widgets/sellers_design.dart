import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/mainScreens/menus_screen.dart';
import 'package:foodpanda_users_app/models/sellers.dart';

class SellersDesignWidget extends StatefulWidget {
Sellers? model;

BuildContext? context;

SellersDesignWidget({
  this.model,
  this.context,
});
  @override
  _SellersDesignWidgetState createState() => _SellersDesignWidgetState();
}

class _SellersDesignWidgetState extends State<SellersDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>MenusScreen(model:widget.model!)));
      },
       splashColor: Colors.amber,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          height: 255,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.sellerAvatarUrl!,
height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1,),
              Text(widget.model!.sellerName!,
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                ),
              ),
              Text(widget.model!.sellerEmail!,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12 ,
                ),
              ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

