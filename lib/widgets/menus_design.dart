import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/mainScreens/items_screen.dart';
import 'package:foodpanda_users_app/models/menus.dart';
import 'package:foodpanda_users_app/models/sellers.dart';

class MenusDesignWidget extends StatefulWidget {
  Menus? model;

  BuildContext? context;

  MenusDesignWidget({
    this.model,
    this.context,
  });
  @override
  _MenusDesignWidgetState createState() => _MenusDesignWidgetState();
}

class _MenusDesignWidgetState extends State<MenusDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemsScreen(model:widget.model!)));
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
              Text(widget.model!.menuTitle!,
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                ),
              ),
              Text(widget.model!.menuInfo!,
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

