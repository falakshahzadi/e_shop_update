import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminidfeedback.dart';
import 'package:e_shop/Admin/adminidorder.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:flutter/material.dart';

import '../DialogBox/errorDialog.dart';
import '../Widgets/customTextField.dart';

class Adminid extends StatelessWidget {
  const Adminid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.redAccent, Colors.blueAccent],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              // tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(
          "MH GARMENTS",
          style: TextStyle(
              fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
        ),
        centerTitle: true,
      ),
      body: AdminIdScreen(),
    );
  }
}
class AdminIdScreen extends StatefulWidget {
  @override
  _AdminIdScreenState createState() => _AdminIdScreenState();
}

class _AdminIdScreenState extends State<AdminIdScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _adminIDTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    //  _screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.redAccent, Colors.blueAccent],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/admin.png",
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Admin",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _adminIDTextEditingController,
                    data: Icons.person,
                    hintText: "id",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.person,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {
                _adminIDTextEditingController.text.isNotEmpty &&
                        _passwordTextEditingController.text.isNotEmpty
                    ? loginAdminId()
                    : showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorAlertDialog(
                            message: "Please write email and password.",
                          );
                        });
              },
              color: Colors.red,
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
             ),
            SizedBox(
              height: 50.0,
            ),
             Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.red,
            ),
            SizedBox(
              height: 20.0,
            ),
            // ignore: deprecated_member_use
            FlatButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AuthenticScreen())),
              icon: (Icon(
                Icons.nature_people,
                color: Colors.red,
              )),
              label: Text(
                "Logout",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }

  loginAdminId() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result["id"] != _adminIDTextEditingController.text.trim()) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("Your id is not correct.")),
          );
        } else if (result["password"] !=
            _passwordTextEditingController.text.trim()) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("Your password is not correct.")),
          );
        } else {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Welcome dear Admin." + result["name"]),
            ),
          );

          setState(() {
            _adminIDTextEditingController.text = "";
            _passwordTextEditingController.text = "";
          });
            // Route route = MaterialPageRoute(builder: (c) => UploadPage());
          // Navigator.pushReplacement(context, route);
        
 }
      });
    });
  }
}

  displayAdminIdHomeScreen() {
    
        return DefaultTabController(
          length: 2,
    
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.redAccent, Colors.blueAccent],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
           title: Text(
            "Admin",
            style: TextStyle(
                fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
          ),
          centerTitle: true,
           bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
                text: "Orders",
              ),
              Tab(
                icon: Icon(
                  Icons.mode_edit_outline,
                  color: Colors.white,
                ),
                text: "Feedback",
              ),
            ],
          indicatorColor: Colors.white38,
            indicatorWeight: 5.0,
          ),
        ),
        body: Container(
           decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.redAccent, Colors.blueAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        child: TabBarView(
            children: [
              AdminIdFeedback(),
              AdminIdorder(),
            ],
          
        ),
        ),
      ),
        );
    
    
             
  }