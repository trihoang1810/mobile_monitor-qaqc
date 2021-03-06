import 'package:flutter/material.dart';
import 'package:mobile_app/function/func.dart';
import 'package:mobile_app/presentations/widgets/constant.dart';
import 'package:mobile_app/presentations/widgets/widget.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => new _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
 
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Constants.secondaryColor,
          ),
          child: Drawer(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Constants.mainColor,
                  ),
                  width: SizeConfig.screenHeight * 0.5121,
                  height: SizeConfig.screenHeight * 0.3841,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: SizeConfig.screenHeight * 0.05121),
                      // Text(
                      //   employeeLastNameOverall +
                      //       " " +
                      //       employeeFirstNameOverall,
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 25,
                      //       color: Colors.white),
                      //   textAlign: TextAlign.center,
                      // ),
                      // SizedBox(height: SizeConfig.screenHeight * 0.05121),
                      // Text(
                      //   employeeIdOverall,
                      //   style: TextStyle(
                      //       fontStyle: FontStyle.italic,
                      //       fontSize: 25,
                      //       color: Colors.white),
                      //   textAlign: TextAlign.center,
                      // ),
                      SizedBox(height: SizeConfig.screenHeight * 0.03841),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: SizeConfig.screenHeight * 0.0192),
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    TextButton(
                      onPressed: () {
                        logout(context);
                      },
                      child: Text(
                        "????ng xu???t",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: true, //t??? t???o n??t ra drawer
          backgroundColor: Constants.mainColor,
          //leading: IconButton(
          //icon: Icon(
          //Icons.menu,
          //color: Colors.white,
          //),
          // onPressed: () {},
          //),
          title: Text("Menu"),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            // <>children
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(
                height: SizeConfig.screenHeight * 0.0384,
              ),
              Text(
                "PH??NG GI??M S??T KI???M TRA CH???T L?????NG S???N PH???M",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'lib/assets/CHAlogo.png',
                      width: SizeConfig.screenWidth * 0.3056,
                    ),
                    SizedBox(width: SizeConfig.screenWidth * 0.0764),
                    Image.asset(
                      'lib/assets/BK_VIAMLAB.png',
                      width: SizeConfig.screenWidth * 0.3056,
                    ),
                  ]),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              CustomizedButton(
                text: 'B??O C??O',
                onPressed: () {
                  Navigator.pushNamed(context, '/reportmodescreen');
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.0192),
              CustomizedButton(
                text: 'GI??M S??T',
                onPressed: () {
                  Navigator.pushNamed(context, '/monitormodescreen');
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.12804),
            ],
          ),
        ),
      ),
    );
  }
}
