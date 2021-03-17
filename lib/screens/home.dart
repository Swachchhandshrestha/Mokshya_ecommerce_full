import 'package:carousel_pro/carousel_pro.dart';
import 'package:mokshyauser/helpers/common.dart';
import 'package:mokshyauser/helpers/style.dart';
import 'package:mokshyauser/provider/product.dart';
import 'package:mokshyauser/provider/user.dart';
import 'package:mokshyauser/screens/notification.dart';
import 'package:mokshyauser/screens/product_search.dart';
import 'package:mokshyauser/screens/profile.dart';
import 'package:mokshyauser/services/product.dart';
import 'package:mokshyauser/widgets/buttom_nav_all.dart';
import 'package:mokshyauser/widgets/custom_text.dart';
import 'package:mokshyauser/widgets/featured_card.dart';
import 'package:mokshyauser/widgets/featured_products.dart';
import 'package:mokshyauser/widgets/horizontal_listview.dart';
import 'package:mokshyauser/widgets/product_card.dart';
import 'package:mokshyauser/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:mokshyauser/screens/login.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mokshyauser/screens/cart.dart';
import 'package:mokshyauser/services/push_notification_service.dart';
import 'cart.dart';
import 'order.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();
  ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    Widget image_carousal = new Container(
      height: 200.0,
      child: Carousel(
        images: [
          AssetImage('images/back_monitor.jpg'),
          AssetImage('images/back_biometric.png'),
          AssetImage('images/back_cam.jpg'),
          AssetImage('images/back_cake.png'),
          AssetImage('images/back_harddisk.png'),
          AssetImage('images/back_switch.png'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        dotSize: 5.0,
        indicatorBgPadding: 10.0,
        animationDuration: Duration(
          microseconds: 500,
        ),
      ),
    );

    final userProvider = Provider.of<UserProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#660099"),
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: AssetImage("images/logowhite.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeaturedCard()));
                },
                child: Text("Mokshya Store"),
              ),
            ),
          ],
        ),
        actions: [
          new IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
          new IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          new IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _key.currentState.openEndDrawer();
            },
          ),
        ],
      ),
      key: _key,
      backgroundColor: white,
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: HexColor("#6B01A0"),
              ),
              currentAccountPicture: Center(
                  child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage("images/background.jpg"),
              )),
              accountName: CustomText(
                text: userProvider.userModel?.name ?? "username lading...",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: userProvider.userModel?.email ?? "email loading...",
                color: white,
              ),
            ),
            ListTile(
              onTap: () async {
                await userProvider.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My orders"),
            ),
            ListTile(
              onTap: () {
                // userProvider.getProfile();
                changeScreen(context, ProfileScreen());
              },
              leading: Icon(Icons.person),
              title: CustomText(text: "My Profile"),
            ),
            ListTile(
              onTap: () {
                userProvider.signOut();
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ButtomNav(),
      body: SafeArea(
        child: Container(
          color: HexColor("#E5FAFB"),
          child: ListView(
            children: <Widget>[
//          Search Text field
              //  Search(),

              Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.search,
                        color: black,
                      ),
                      title: TextField(
                        textInputAction: TextInputAction.search,
                        onSubmitted: (pattern) async {
                          await productProvider.search(productName: pattern);
                          changeScreen(context, ProductSearchScreen());
                        },
                        decoration: InputDecoration(
                          hintText: "Search Products",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              image_carousal,

              Padding(
                //padding widget for Categories
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'OUR CATAGORIES',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 15),
                ),
              ),
              //horizontal list view remains here
              HorizontalList(),

//            featured products

              Padding(
                //padding widget for Categories
                padding: EdgeInsets.all(10.0),

                child: InkWell(
                  // onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => FeaturedCard()));
                  // },
                  child: Text(
                    'FEATURED PRODUCT',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 15),
                  ),
                ),
              ),
              FeaturedProducts(),

//          recent products
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text(
                        'RECENT PRODUCT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: productProvider.products
                    .map((item) => GestureDetector(
                          child: ProductCard(
                            product: item,
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//Row(
//mainAxisAlignment: MainAxisAlignment.end,
//children: <Widget>[
//GestureDetector(
//onTap: (){
//key.currentState.openDrawer();
//},
//child: Icon(Icons.menu))
//],
//),
