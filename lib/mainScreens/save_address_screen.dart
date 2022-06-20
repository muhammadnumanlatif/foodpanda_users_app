import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/widgets/simple_app_bar.dart';
import 'package:foodpanda_users_app/widgets/text_field.dart';

class SaveAddressScreen extends StatelessWidget {
  SaveAddressScreen({Key? key}) : super(key: key);

  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _completeAddress = TextEditingController();
  final _locationController = TextEditingController();
 final _flatNumber= TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
        //save address info-
        },
        label: Text("Save Now"),
        backgroundColor: Colors.cyan,
        icon: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Save Address",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_pin_circle,
                color: Colors.black,
                size: 35,
              ),
              title: Container(
                width: 250,
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: _locationController,
                  decoration: InputDecoration(
                    hintText: "What's your address?",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
              SizedBox(height: 10,),
              ElevatedButton.icon(onPressed: (){
                //get current location with address
              }, icon: Icon(Icons.location_on), label:Text("Current Location"  ),
              style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color:Colors.cyan
                )
              ))
              ),
              ),

            Form(
              key: formKey,
              child: Column(
                children: [
                  MyTextField(
                    controller: _name,
                    hint: "Name",
                  ),
                  MyTextField(
                    controller: _phoneNumber,
                    hint: "Phone",
                  ),
                  MyTextField(
                    controller: _city,
                    hint: "City",
                  ),
                  MyTextField(
                    controller: _state,
                    hint: "State / Country",
                  ),
                  MyTextField(
                    controller: _flatNumber,
                    hint: "Address Line"
                        ,
                  ),
                  MyTextField(
                    controller: _completeAddress,
                    hint: "Complete Address",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
