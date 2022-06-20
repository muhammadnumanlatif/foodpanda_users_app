import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/mainScreens/save_address_screen.dart';
import 'package:foodpanda_users_app/widgets/app_bar.dart';
import 'package:foodpanda_users_app/widgets/simple_app_bar.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({Key? key, required this.sellerUID, required this.totalAmount})
      : super(key: key);
  final String sellerUID;
  final double totalAmount;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(),
      floatingActionButton: FloatingActionButton.extended(
 onPressed: (){
   Navigator.push(context,MaterialPageRoute(builder: (c)=>SaveAddressScreen()));
 },
        label: Text("Add New Address"),
        backgroundColor: Colors.cyan,
        icon: Icon(Icons.add_location),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
     Align(
       alignment: Alignment.centerLeft,
       child: Padding(
         padding: EdgeInsets.all(8.0),
         child: Text(
           "Select Address",
           style: TextStyle(
             color: Colors.black,
             fontWeight: FontWeight.bold,
             fontSize: 20,
           ),
         ),
       ),

     )
        ],
      ),
    );
  }
}
