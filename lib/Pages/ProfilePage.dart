import 'package:command_flutter/LoginPage.dart';
import 'package:command_flutter/Model/User.dart';
import 'package:command_flutter/Pages/EditProfilePage.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:command_flutter/Widget/ButtonWidget.dart';
import 'package:command_flutter/Widget/ProfileWidget.dart';
import 'package:flutter/material.dart';

class ProfileePage extends StatefulWidget {
  const ProfileePage({Key? key}) : super(key: key);

  @override
  State<ProfileePage> createState() => _ProfileePageState();
}

class _ProfileePageState extends State<ProfileePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPereferences.myUser;
    return Scaffold(
      //appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePatch: user.imagePath,
              onCliced: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfilePage())
                    );
              },
            ),
            const SizedBox(height: 12),
            buildName(user),
            const SizedBox(height: 12),
            const SizedBox(height: 330),
            Expanded(
              child: Align(
              alignment: Alignment(1, 1),
                  child: buildExitProfileButton()),
            ),
          ],
        ),
      ),
    );
  }

  buildName(User user) => Column(
      children: [
        Text(
          user.name,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
        ),
        Text(
          user.email,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );

  Widget buildExitProfileButton() => ButtonWidget(
    text:'Exit',
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginPage())
      );
    },
  );
  }
