import 'package:chat/Authenticate/Methods.dart';
import 'package:chat/Screens/in_notifications.dart';
import 'package:chat/group_chats/group_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: dashBoardAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  "Part 1 contains the notification feature",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Nunito',
                  ),
                ),
                SizedBox(height: height * 0.05),
                Container(
                  height: height * 0.06,
                  width: width * 0.6,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => InnAppNotification(),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(HexColor("5685FF")),
                      elevation: MaterialStateProperty.all(10),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Part 1',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.2),
          Center(
            child: Column(
              children: [
                Text(
                  "Part 2 contains the group chat",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Nunito',
                  ),
                ),
                SizedBox(height: height * 0.05),
                Container(
                  height: height * 0.06,
                  width: width * 0.6,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GroupChatHomeScreen(),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(HexColor("5685FF")),
                      elevation: MaterialStateProperty.all(10),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Part 2',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar dashBoardAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.grid_view_rounded,
              color: HexColor("5685FF"),
              size: 30,
            ),
            onPressed: () {},
          );
        },
      ),
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
          "Dashboard",
          style: TextStyle(
            color: HexColor("5685FF"),
            fontSize: 15,
            fontFamily: 'Nunito',
          ),
        ),
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.logout,
              color: HexColor("5685FF"),
            ),
            onPressed: () => logOut(context))
      ],
    );
  }
}
