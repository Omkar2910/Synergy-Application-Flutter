import 'package:flutter/material.dart';
import 'package:synergy_rider_app/authentication/auth_screen.dart';
import 'package:synergy_rider_app/global/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


    Card makeDashboardItem(String title, IconData iconData, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? const BoxDecoration(
                gradient: LinearGradient(
                colors: [
                  Colors.amber,
                  Colors.cyan,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
                
              ))
            : const BoxDecoration(
                gradient: LinearGradient(
                colors: [
                  Colors.redAccent,
                  Colors.amber,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
              ),
              child:InkWell(
                onTap: ()
                {
                  if(index==0)
                  {
                    // New Orders
                  }
                  if(index==1)
                  {
                    // Parcels in progress
                  }
                  if(index==2)
                  {
                    // Not yet delivered
                  }
                  if(index==3)
                  {
                    // History
                  }
                  if(index==4)
                  {
                    // Total Earnings
                  }
                  if(index==5)
                  {
                    // Logout
                    firebaseAuth.signOut().then((value)
                    {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const AuthScreen()));
                    });
                  }

                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    const SizedBox(height: 50.0),
                    Center(
                      child: Icon(
                        iconData,
                        size : 40,
                        color : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w300,            // grid user interface
                        ), 
                      ),
                    ),
                    
                  ],
                ),
              ),

      ),
      
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.cyan,
              Colors.amber,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: Text(
         "Welcome "+ sharedPreferences!.getString("name")!,
        style:const TextStyle(
          fontSize: 40,
          fontFamily: "Signatra",
          fontWeight: FontWeight.w400,
          color: Colors.black45,
        ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
       body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        padding:  const EdgeInsets.symmetric(vertical: 50,horizontal: 1),
        child: GridView.count(
          
          crossAxisCount: 2,
          padding: const EdgeInsets.all(2),
          children: [
            makeDashboardItem("Orders Available", Icons.assignment, 0),
            makeDashboardItem("In Progress", Icons.airport_shuttle, 1),
            makeDashboardItem("Yet to Deliver", Icons.location_history, 2),
            makeDashboardItem("History", Icons.done_all, 3),
            makeDashboardItem("Total Earnings", Icons.monetization_on, 4),
            makeDashboardItem("LogOut", Icons.logout, 5)
          ],
          
          ),
      
      ),
    );
  }
}
