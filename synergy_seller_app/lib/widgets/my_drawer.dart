import 'package:flutter/material.dart';
import 'package:seller_app/global/global.dart';
import 'package:seller_app/mainScreens/earnings_screen.dart';
import 'package:seller_app/mainScreens/history_screen.dart';
import 'package:seller_app/mainScreens/new_orders_screen.dart';

import '../authentication/auth_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        //Header drawer
        Container(
          padding: const EdgeInsets.only(top: 25, bottom: 10),
          child: Column(
            children: [
              Material(
                borderRadius: const BorderRadius.all(Radius.circular(80)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    height: 160,
                    width: 160,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                sharedPreferences!.getString("name")!,
                style: const TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: "Train"),
              )
            ],
          ),
        ),

        const SizedBox(height: 12),

        //Body drawer
        Container(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              const Divider(height: 10, color: Colors.grey, thickness: 2),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.black),
                title:
                    const Text("Home", style: TextStyle(color: Colors.black)),
                onTap: () {
                  //
                },
              ),
              const Divider(height: 10, color: Colors.grey, thickness: 2),
              ListTile(
                leading: const Icon(Icons.monetization_on, color: Colors.black),
                title: const Text("My Earnings",
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (c) => const EarningsScreen()));
                },
              ),
              const Divider(height: 10, color: Colors.grey, thickness: 2),
              ListTile(
                leading: const Icon(Icons.reorder, color: Colors.black),
                title: const Text("New Orders",
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (c) => NewOrdersScreen()));
                },
              ),
              const Divider(height: 10, color: Colors.grey, thickness: 2),
              ListTile(
                leading: const Icon(Icons.local_shipping, color: Colors.black),
                title: const Text("Orders History",
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (c) => HistoryScreen()));
                },
              ),
              const Divider(height: 10, color: Colors.grey, thickness: 2),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.black),
                title: const Text("Sign out",
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  firebaseAuth.signOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (c) => const AuthScreen()));
                  });
                },
              ),
              const Divider(height: 10, color: Colors.grey, thickness: 2),
            ],
          ),
        )
      ]),
    );
  }
}
