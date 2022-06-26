import 'package:chat/group_chats/create_group/add_members.dart';
import 'package:chat/group_chats/group_chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupChatHomeScreen extends StatefulWidget {
  const GroupChatHomeScreen({Key key}) : super(key: key);

  @override
  _GroupChatHomeScreenState createState() => _GroupChatHomeScreenState();
}

class _GroupChatHomeScreenState extends State<GroupChatHomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;
  bool isLoading = true;

  List groupList = [];

  @override
  void initState() {
    super.initState();
    getAvailableGroups();
  }

  void getAvailableGroups() async {
    String uid = _fireAuth.currentUser.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get()
        .then((value) {
      setState(() {
        groupList = value.docs;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: dashBoardAppBar(),
      body: isLoading
          ? Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : groupList.length == 0
              ? Center(
                  child: Text(
                    "No group made yet!",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: groupList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => GroupChatRoom(
                            groupName: groupList[index]['name'],
                            groupChatId: groupList[index]['id'],
                          ),
                        ),
                      ),
                      leading: Icon(Icons.group),
                      title: Text(groupList[index]['name']),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        backgroundColor: HexColor("5685FF"),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddMembersInGroup(),
          ),
        ),
        tooltip: "Create Group",
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
          "All Groups",
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
