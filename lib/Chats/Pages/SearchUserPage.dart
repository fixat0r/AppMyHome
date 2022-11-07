import 'package:cloud_firestore/cloud_firestore.dart';
import '/Chats/Data/Admin.dart';
import '/Chats/Pages/ChatPage.dart';

import 'package:flutter/material.dart';

class SearchUserPage extends StatefulWidget {
  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchController.text)
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Нет такого пользователя.\n(Возможно вы ввели имя не полностью)"),
        ));
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['name'] != myUsername) {
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });
  }

    void onSearchChanged() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchController.text)
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['name'] != myUsername) {
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          controller: searchController,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white70),
            hintText: "Введите имя пользователя....",
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.search,
          onChanged: (value){
            onSearchChanged();
          },
          onSubmitted: (value) {
            onSearch();
          },
        ),
      ),
      body: Column(
        children: [
          if (searchResult.length > 0)
            Expanded(
                child: ListView.builder(
                    itemCount: searchResult.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: CircleAvatar(
                            child:
                                Image.network(searchResult[index]['urlAvatar']),
                          ),
                          title: Text(searchResult[index]['name']),
                          subtitle: Text(searchResult[index]['description']),
                          onTap: () {
                            setState(() {
                              searchController.text = "";
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                        currentUserId: myId,
                                        friendId: searchResult[index]['idUser'],
                                        friendName: searchResult[index]['name'],
                                        friendDescription: searchResult[index]
                                            ['description'],
                                        friendImage: searchResult[index]
                                            ['urlAvatar'])));
                          },
                          trailing: Icon(Icons.message));
                    }))
          else if (isLoading == true)
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
