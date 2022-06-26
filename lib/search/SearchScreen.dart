import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gam3a/component/components.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    inputText = val;
                    print(inputText);
                  });
                },
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("property")
                          .where("Title",
                          isGreaterThanOrEqualTo: inputText)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Something went wrong"),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Text("Loading"),
                          );
                        }

                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                            return Container(
                              width: 200,
                              height: 100,
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(data['Title']),
                                  leading: Image.network(data['image']),
                                  onTap: () {
                                    defulatCard;
                                  }
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
