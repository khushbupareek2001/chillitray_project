import 'package:chat/model/notification.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InnAppNotification extends StatefulWidget {
  const InnAppNotification({Key key}) : super(key: key);

  @override
  _InnAppNotificationState createState() => _InnAppNotificationState();
}

class _InnAppNotificationState extends State<InnAppNotification> {
  List<Notifications> notificationList = [];
  Future<void> fetchNoti() async {
    // bool check = false;
    final url =
        "https://chatapp-5336a-default-rtdb.firebaseio.com/Notification.json";
    // "https://test-notification-e8594-default-rtdb.firebaseio.com/Notification.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((promoId, promoData) {
        notificationList.add(new Notifications(
            uniqueId: promoId,
            text: promoData["text"],
            seen: promoData["seen"]));
        print(promoId +
            " " +
            promoData["text"] +
            " " +
            promoData["seen"].toString());
      });
      setState(() {});
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateOrder(Notifications noti) async {
    final url = Uri.parse(
        'https://chatapp-5336a-default-rtdb.firebaseio.com/Notification/${noti.uniqueId}.json'
        // 'https://test-notification-e8594-default-rtdb.firebaseio.com/Notification/${noti.uniqueId}.json',
        );
    final response = await http.patch(url,
        body: json.encode({
          "text": noti.text,
          "seen": true,
        }));
    setState(() {});
    // _items.remove(_tailor);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNoti();
    // _controller.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: dashBoardAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height * 0.88,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(15, width * 0.1, 15, 15),
            itemCount: notificationList.length,
            itemBuilder: (_, i) => GestureDetector(
              onTap: () {
                updateOrder(notificationList[i]);
                setState(() {});
                notificationList[i].seen = true;
                const snackBar = SnackBar(
                  content:
                      Text('Notification seen', textAlign: TextAlign.center),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Container(
                decoration: notificationList[i].seen == false
                    ? BoxDecoration(
                        color: HexColor("D8E2FC"),
                        borderRadius: BorderRadius.circular(15))
                    : BoxDecoration(color: Colors.white),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[400],
                  ),
                  title: Text(
                    notificationList[i].text,
                    textScaleFactor: 1,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    notificationList[i].uniqueId,
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
            // itemCount: notificationList.length,
            // itemBuilder: (_, i) => notificationTile(
            //   context,
            //   notificationList[i].notificationId,
            //   notificationList[i].title,
            //   notificationList[i].description,
            //   notificationList[i].seenOrNot,
            //   notificationList[i].userpathid,
            // ),
          ),
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
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.west_outlined,
            color: HexColor("5685FF"),
          ),
        ),
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
          "Notifications",
          style: TextStyle(
            color: HexColor("5685FF"),
            fontSize: 15,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }
}

// class NotificationModel {
//   String notificationId;
//   String title;
//   String description;
//   String seenOrNot;
//   String userpathid;

//   NotificationModel({
//     required this.notificationId,
//     required this.title,
//     required this.description,
//     required this.seenOrNot,
//     required this.userpathid,
//   });
// }
