import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget  {
  SimpleAppBar({Key? key, this.bottom}) : super(key: key);
  final PreferredSizeWidget? bottom;
  @override
  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
  @override
  Widget build(BuildContext context) {
    return    AppBar(
    flexibleSpace: Container(
    decoration: const BoxDecoration(
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
    );
  }
}
