import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/mainScreens/item_detail_screen.dart';
import 'package:foodpanda_users_app/models/items.dart';
import 'package:foodpanda_users_app/models/sellers.dart';

class ItemsDesignWidget extends StatefulWidget {
  Items? model;

  BuildContext? context;

  ItemsDesignWidget({
    this.model,
    this.context,
  });
  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemDetailScreen(model:widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          height: 265,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1,),
              Text(widget.model!.title!,
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                ),
              ),
              Text(widget.model!.shortInfo!,
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

