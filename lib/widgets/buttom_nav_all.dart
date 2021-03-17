import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mokshyauser/screens/cart.dart';
import 'package:mokshyauser/screens/home.dart';
import 'package:mokshyauser/screens/notification.dart';
import 'package:mokshyauser/screens/profile.dart';



class ButtomNav extends StatefulWidget {
  @override
  _ButtomNavState createState() => _ButtomNavState();
}

class _ButtomNavState extends State<ButtomNav> {
        int _currentIndex = 0;
 final List<Widget> _children=[
    HomePage(),
    NotiFication(),
    CartScreen(),
    ProfileScreen()
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override

  Widget build(BuildContext context) {
    return  BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 20.0,
        selectedFontSize: 17,
        unselectedFontSize: 15.0,
        selectedItemColor: HexColor("#0360BC"),
        unselectedItemColor: HexColor("#660099"),
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.message),
            title: new Text('Messages'),
            
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.shopping_cart),
            title: new Text('Cart'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
        onTap: (index) {
          _currentIndex = index;
          setState(() {
            
            Navigator.push(context, MaterialPageRoute(builder: (context)=>_children[_currentIndex]));
          });
        },
    );
  }
}



    
 
    
   