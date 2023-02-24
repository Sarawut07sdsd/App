import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter_application_1/menu.dart';
import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const Color primary = Color(0xfff2f9fe);
const Color secondary = Color(0xFFdbe4f3);
const Color black = Color(0xFF000000);
const Color white = Color(0xFFFFFFFF);
const Color grey = Colors.grey;
const Color red = Color(0xFFec5766);
const Color green = Color(0xFF43aa8b);
const Color blue = Color(0xFF28c2ff);
const Color buttoncolor = Color(0xff3e4784);
const Color mainFontColor = Color(0xff565c95);
const Color arrowbgColor = Color(0xffe4e9f7);

class DailyPage extends StatefulWidget {
  const DailyPage({super.key});

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
    

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String datetime2 = "";
  String datetime0 = "";
  String datetime3 = "";
var latitude ="";
var longitude = "";
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  void initState() {
    Timer mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime datetime = DateTime.now();
      print(datetime.toString());
      datetime2 = DateFormat.Hms().format(datetime);
      _getPosition();
      
      setState(() {});
      //mytimer.cancel() //to terminate this timer
    });
    super.initState();
      
  }

Future<void> _getPosition() async {
    final  Position position = await getCurrentLocation();
                print(position.latitude); // พิกัดละติจูด
                print(position.longitude); // พิกัดลองติจูด
    setState(() {
     latitude = position.latitude.toString();
     longitude = position.longitude.toString();
    });
  }


  ///////// Dialg ///////////////////////////////////////////////////

  Future<void> _showAlertGoToWork() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('ยืนยันการบันทึกเวลาเข้างานของคุณ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'เวลาที่คุณบันทึกเวลาเข้าจะตรงกับเวลาปัจจุบัน !!',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ยืนยีน'),
              onPressed: () async {
                Position position = await getCurrentLocation();
                print(position.latitude); // พิกัดละติจูด
                print(position.longitude); // พิกัดลองติจูด
                final prefs = await SharedPreferences.getInstance();
                final user = prefs.getString('user');
                final url = Uri.parse(
                        'http://localhost/1Projest/leave_system/leave_system/apiApp/gps.php?latitude=' +
                            latitude.toString() +
                            '&longitude=' +
                            longitude.toString() +
                            '&user=' +
                            user.toString() +
                            '&str=in'
                            );
                    final response = await http.get(url);
                    var jsonResponse = convert.jsonDecode(response.body)
                        as Map<String, dynamic>;
                    print(jsonResponse);
                    var success = jsonResponse['success'];


                // Navigator.of(context).pop();
                // Navigator.push<void>(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //             const WebViewContainer('')));
              },
            ),
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAlertWorkOut() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('ยืนยันการบันทึกเวลาออกงานของคุณ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'เวลาที่คุณบันทึกเวลาออกงานจะตรงกับเวลาปัจจุบัน !!',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ยืนยีน'),
              onPressed: () async {
                Position position = await getCurrentLocation();
                print(position.latitude); // พิกัดละติจูด
                print(position.longitude); // พิกัดลองติจูด
                final prefs = await SharedPreferences.getInstance();
                final user = prefs.getString('user');
                final url = Uri.parse(
                        'http://localhost/1Projest/leave_system/leave_system/apiApp/gps.php?latitude=' +
                            latitude.toString() +
                            '&longitude=' +
                            longitude.toString() +
                            '&user=' +
                            user.toString()  +
                            '&str=out');
                    final response = await http.get(url);
                    var jsonResponse = convert.jsonDecode(response.body)
                        as Map<String, dynamic>;
                    print(jsonResponse);
                    var success = jsonResponse['success'];


                // Navigator.of(context).pop();
                // Navigator.push<void>(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => const WorkOut('')));
              },
            ),
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ตัวอย่างการใช้งาน Geolocator เพื่อดึงข้อมูลพิกัด
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // ตรวจสอบสิทธิ์การเข้าถึงตำแหน่งปัจจุบันของอุปกรณ์
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }

    // ดึงข้อมูลพิกัดปัจจุบันของอุปกรณ์
    return await Geolocator.getCurrentPosition();
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////

 

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.03),
                    spreadRadius: 10,
                    blurRadius: 3,
                    // changes position of shadow
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 25, right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.bar_chart),
                      Icon(Icons.more_vert)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: (size.width - 40) * 0.6,
                        child: Column(
                          children: [
                            Text(
                              "ตำแหน่งล่าสุดของคุณ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: mainFontColor),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "ละติจุ : $latitude ลองติจุ : $longitude ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                            ),
                           

                          ],
                        ),
                      )
                    ],
                  ),

                  
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                            "ยินดีต้อนรับเข้าสู่หน้า ลงเวลาเข้า & ออกงาน  ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: mainFontColor,
                            )),
                      ],
                    )
                  ],
                ),
                // Text("Overview",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 20,
                //       color: mainFontColor,
                //     )),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 25,
                          right: 25,
                        ),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: grey.withOpacity(0.03),
                                spreadRadius: 10,
                                blurRadius: 3,
                                // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 20, left: 20),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: arrowbgColor,
                                  borderRadius: BorderRadius.circular(15),
                                  // shape: BoxShape.circle
                                ),
                                child: const Center(
                                    child: Icon(Icons.airplane_ticket)),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                  width: (size.width - 90) * 0.7,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ' เวลาปัจจุบัน  :  ' + datetime2,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 25,
                          right: 25,
                        ),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: grey.withOpacity(0.03),
                                spreadRadius: 10,
                                blurRadius: 3,
                                // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 20, left: 20),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: arrowbgColor,
                                  borderRadius: BorderRadius.circular(15),
                                  // shape: BoxShape.circle
                                ),
                                child: const Center(
                                    child: Icon(Icons.airplane_ticket)),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                  child: ElevatedButton(
                                      child: const Text('ลงเวลาเข้างาน',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: _showAlertGoToWork),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 25,
                          right: 25,
                        ),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: grey.withOpacity(0.03),
                                spreadRadius: 10,
                                blurRadius: 3,
                                // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 20, left: 20),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: arrowbgColor,
                                  borderRadius: BorderRadius.circular(15),
                                  // shape: BoxShape.circle
                                ),
                                child: const Center(
                                    child: Icon(Icons.airplane_ticket)),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                  child: ElevatedButton(
                                      child: const Text('ลงเวลาออกงาน',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: _showAlertWorkOut),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          left: 25,
                          right: 25,
                        ),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: grey.withOpacity(0.03),
                                spreadRadius: 10,
                                blurRadius: 3,
                                // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 20, left: 20),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: arrowbgColor,
                                  borderRadius: BorderRadius.circular(15),
                                  // shape: BoxShape.circle
                                ),
                                child: const Center(
                                    child: Icon(Icons.arrow_downward_rounded)),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                  width: (size.width - 90) * 0.7,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "เข้างาน",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "เข้างาน ก่อน 08.10 = ปกติ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: black.withOpacity(0.5),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "เข้างาน เกิน 08.10 = สาย",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: black.withOpacity(0.5),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "เงื่อนไขการลงเวลาเข้างาน",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: black),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          left: 25,
                          right: 25,
                        ),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: grey.withOpacity(0.03),
                                spreadRadius: 10,
                                blurRadius: 3,
                                // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 20, left: 20),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: arrowbgColor,
                                  borderRadius: BorderRadius.circular(15),
                                  // shape: BoxShape.circle
                                ),
                                child: const Center(
                                    child: Icon(CupertinoIcons.money_dollar)),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                  width: (size.width - 90) * 0.7,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ออกงาน",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "ออกงาน ก่อน 17.00 = ก่อนเวลา ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: black.withOpacity(0.5),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "ออกงาน หลัง 17.00 = ปกติ ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: black.withOpacity(0.5),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "เงื่อนไขการออกงาน",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: black),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// เข้างาน
class WebViewContainer extends StatelessWidget {
  final String webViewUrl;

  const WebViewContainer(this.webViewUrl, {Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return const Center(
      child: Text('บันทึกเวลาเข้างานสำเร็จ !!',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 180, 45),
              fontSize: 48,
              fontWeight: FontWeight.bold)),
    );
  }
}

// ออกงาน
class WorkOut extends StatelessWidget {
  final String webViewUrl;

  const WorkOut(this.webViewUrl, {Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return const Center(
      child: Text('บันทึกเวลาออกงานสำเร็จ !!' + '',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 180, 45),
              fontSize: 48,
              fontWeight: FontWeight.bold)),
    );
  }
}
