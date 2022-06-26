import 'package:chat/Authenticate/Methods.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Screens/HomeScreen.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _accN = TextEditingController();
  final TextEditingController _accE = TextEditingController();
  final TextEditingController _accP = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: dashBoardAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.08,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Enter User Name:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "User Name", Icons.account_box, _accN),
            ),
            SizedBox(height: height * 0.05),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Enter Email ID:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "Email", Icons.account_box, _accE),
            ),
            SizedBox(height: height * 0.05),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Enter Password:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "Password", Icons.lock, _accP),
            ),
            SizedBox(height: height * 0.07),
            customButton(size),
            SizedBox(height: height * 0.05),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: HexColor("5685FF"),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar dashBoardAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      centerTitle: true,
      title: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: HexColor("5685FF"),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          "Create Account",
          style: TextStyle(
            color: HexColor("5685FF"),
            fontSize: 15,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_accN.text.isNotEmpty &&
            _accE.text.isNotEmpty &&
            _accP.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          createAccount(_accN.text, _accE.text, _accP.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });

              const snackBar = SnackBar(
                content: Text('Account Created Sucessfully',
                    textAlign: TextAlign.center),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
              print("Account Created Sucessfully");
            } else {
              print("Login Failed");
              const snackBar = SnackBar(
                content: Text('Login Failed', textAlign: TextAlign.center),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please fill the details correctly");
          const snackBar = SnackBar(
            content: Text('Please fill the details correctly',
                textAlign: TextAlign.center),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: HexColor("5685FF"),
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 30),
          child: Text(
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
