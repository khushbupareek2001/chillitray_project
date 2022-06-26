import 'package:chat/Authenticate/CreateAccount.dart';
import 'package:chat/Screens/HomeScreen.dart';
import 'package:chat/Authenticate/Methods.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _logE = TextEditingController();
  final TextEditingController _logP = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: dashBoardAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Enter Email ID:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: height * 0.05),
            Container(
              width: width,
              alignment: Alignment.center,
              child: field(size, "email", Icons.account_box, _logE),
            ),
            SizedBox(height: height * 0.05),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Enter password:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: height * 0.05),
            Container(
              width: width,
              alignment: Alignment.center,
              child: field(size, "password", Icons.lock, _logP),
            ),
            SizedBox(
              height: height / 10,
            ),
            customButton(size),
            SizedBox(
              height: height / 40,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => CreateAccount())),
              child: Center(
                child: Text(
                  "Create Account",
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
          "Welcome",
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
        if (_logE.text.isNotEmpty && _logP.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          logIn(_logE.text, _logP.text).then((user) {
            if (user != null) {
              print("Login Sucessfull");
              setState(() {
                isLoading = false;
              });

              const snackBar = SnackBar(
                content: Text('Login Sucessfully', textAlign: TextAlign.center),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
              const snackBar = SnackBar(
                content: Text('Login Failed', textAlign: TextAlign.center),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
          margin: const EdgeInsets.only(left: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: HexColor("5685FF"),
          ),
          alignment: Alignment.center,
          child: Text(
            "Login",
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
