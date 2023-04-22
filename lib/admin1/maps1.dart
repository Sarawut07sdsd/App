import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:enhanced_drop_down/enhanced_drop_down.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/menu.dart';
import 'package:flutter_application_1/admin1/addLa.dart';

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

class TransectionPage extends StatefulWidget {
  const TransectionPage({super.key});

  @override
  State<TransectionPage> createState() => _TransectionPageState();
}

class MyAPI {
  static Future<List<dynamic>> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    final response = await http.get(Uri.parse(
        'http://localhost/1Projest/leave_system/leave_system/apiApp/Tabla2.php?str=datala&Emp_id=' +
            user.toString()));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class _TransectionPageState extends State<TransectionPage> {
  String dropdownvalue1 = 'ลาป่วย';
  String _selected = "";
  // List of items in our dropdown menu
  var items = [
    'ลาป่วย',
    'ลาเป็นไข้',
    'ลาแล้ว',
    'ลาเลย',
    'ลานะ',
  ];
  List categoryItemlist = [];

  Future getAllCategory() async {
    // var baseUrl = "https://gssskhokhar.com/api/classes/";
    var baseUrl =
        "http://localhost/1Projest/leave_system/leave_system/apiApp/getDataApp.php?str=PeleaveSUM";
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
  }

  var dropdownvalue;
  var dropdownvalueSubject;
  var subjectItemlist = [];

  @override
  void initState() {
    super.initState();
    getAllCategory();
  }

/////////////////////////////////
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(CupertinoIcons.back,color: black,),
      //   actions: [Icon(CupertinoIcons.search,color: black,)],
      //   backgroundColor: primary,elevation: 0,),
      backgroundColor: primary,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    TextEditingController DateText = TextEditingController();
    TextEditingController Date1 = TextEditingController();
    TextEditingController Date2 = TextEditingController();
    String datetime2 = "";

    DateTime datetime = DateTime.now();
    datetime2 = DateFormat.yMMMEd().format(datetime);

    Future<void> _showAlertWorkOut() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            // <-- SEE HERE
            title: const Text('ยืนยันการลางานของคุณ'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                    'การลางานทุกครั้งจะเก็บประวิติการลางานของคุณ',
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ยืนยีน'),
                onPressed: () async {
                  var D1 = Date1.text.toString();
                  var D2 = Date2.text.toString();
                  var DT = DateText.text;
                  var DV = dropdownvalue;
                  if (D1 == '' ||
                      D2 == '' ||
                      DT == '' ||
                      dropdownvalue == '' ||
                      dropdownvalue == '') {
                    Navigator.of(context).pop();
                    Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const ErrorOut('')));
                  } else {
                    final prefs = await SharedPreferences.getInstance();
                    final user = prefs.getString('user');

                    final url = Uri.parse(
                        'http://localhost/1Projest/leave_system/leave_system/apiApp/laApp.php?Leave_start=' +
                            Date1.text.toString() +
                            '&Leave_end=' +
                            Date2.text.toString() +
                            '&Leave_reason=' +
                            DateText.text +
                            '&Type_id=' +
                            dropdownvalue +
                            '&user=' +
                            user.toString());
                    final response = await http.get(url);
                    var jsonResponse = convert.jsonDecode(response.body)
                        as Map<String, dynamic>;
                    print(jsonResponse);
                    var success = jsonResponse['success'];

                    if (success == '1') {
                      Navigator.of(context).pop();
                      Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const WorkOut('')));
                    } else {
                      Navigator.of(context).pop();
                      Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const WorkOutNo('45645645')));
                    }
                  }
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

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder<List<dynamic>>(
              future: MyAPI.fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return DataTable(
                    columns: [
                      DataColumn(label: Text('ลำดับ')),
                      DataColumn(label: Text('ประเภทการลา')),
                      DataColumn(label: Text('จำนวนที่ลาได้')),
                      DataColumn(label: Text('ลาไปแล้ว (วัน)')),
                      DataColumn(label: Text('คงเหลือ (วัน)')),
                      DataColumn(label: Text('')),
                    ],
                    rows: data
                        .map((user) => DataRow(cells: [
                              DataCell(Text(user['num'].toString())),
                              DataCell(Text(user['Type_name'])),
                              DataCell(Text(user['leave_maximum'].toString())),
                              DataCell(Text(user['datesomSum'].toString())),
                              DataCell(Text(user['sum'].toString())),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString(
                                        'Type_id', user['Type_id'].toString());

                                    await SharedPreferences.getInstance();
                                    await prefs.setString('Type_name',
                                        user['Type_name'].toString());
                                    // ทำอะไรสักอย่างเมื่อกดปุ่ม
                                    if (user['sum'] <= 0) {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                              'ไม่สามารถลาประเภทนี้ได้',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 233, 1, 1),
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.bold)),
                                          content: const Text(
                                              'กรุณาตรวจสอบ สิทธิ์การลาของคุณให้เรียบร้อย'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                              'สามารถลางานประเภทนี้ได้ ',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 180, 45),
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.bold)),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.push(
                                                  context, MaterialPageRoute(
                                                      builder: (context) {
                                                return const TransectionPage2();
                                              })),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: Text('เลือก'),
                                ),
                              ),
                            ]))
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to load data'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(color: primary, boxShadow: [
              BoxShadow(
                  color: grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3)
            ]),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 25, right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text("ระบบลางาน",
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20,
          //             color: mainFontColor,
          //           )),
          //     ],
          //   ),
          // ),

          // Padding(
          //   padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text("วันนี้วันที่ :" + datetime2,
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20,
          //             color: mainFontColor,
          //           )),
          //     ],
          //   ),
          // ),

///////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

          // Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         margin: EdgeInsets.only(
          //           top: 10,
          //           left: 25,
          //           right: 25,
          //         ),
          //         decoration: BoxDecoration(
          //             color: white,
          //             borderRadius: BorderRadius.circular(25),
          //             boxShadow: [
          //               BoxShadow(
          //                 color: grey.withOpacity(0.03),
          //                 spreadRadius: 10,
          //                 blurRadius: 3,
          //                 // changes position of shadow
          //               ),
          //             ]),
          //         child: Padding(
          //           padding: const EdgeInsets.only(
          //               top: 10, bottom: 20, right: 20, left: 20),
          //           child: Row(
          //             children: [
          //               Container(
          //                 width: 50,
          //                 height: 50,
          //                 // decoration: BoxDecoration(
          //                 //   color: arrowbgColor,
          //                 //   borderRadius: BorderRadius.circular(15),
          //                 //   // shape: BoxShape.circle
          //                 // ),
          //                 child: Center(
          //                     child: Icon(
          //                   Icons.payment,
          //                   color: mainFontColor,
          //                 )),
          //               ),
          //               SizedBox(
          //                 width: 20,
          //               ),
          //               Expanded(
          //                 child: DropdownButton(
          //                   hint: Text('เลือกประเภทการลางาน'),
          //                   items: categoryItemlist.map((item) {
          //                     return DropdownMenuItem(
          //                       value: item['Type_id'].toString(),
          //                       child: Text(item['name'].toString()),
          //                     );
          //                   }).toList(),
          //                   onChanged: (newVal) {
          //                     setState(() {
          //                       dropdownvalue = newVal.toString();
          //                       print(dropdownvalue);
          //                     });
          //                   },
          //                   value: dropdownvalue,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          // Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         margin: EdgeInsets.only(
          //           top: 10,
          //           left: 25,
          //           right: 25,
          //         ),
          //         decoration: BoxDecoration(
          //             color: white,
          //             borderRadius: BorderRadius.circular(25),
          //             boxShadow: [
          //               BoxShadow(
          //                 color: grey.withOpacity(0.03),
          //                 spreadRadius: 10,
          //                 blurRadius: 3,
          //                 // changes position of shadow
          //               ),
          //             ]),
          //         child: Padding(
          //           padding: const EdgeInsets.only(
          //               top: 10, bottom: 20, right: 20, left: 20),
          //           child: Row(
          //             children: [
          //               Container(
          //                 width: 50,
          //                 height: 50,
          //                 // decoration: BoxDecoration(
          //                 //   color: arrowbgColor,
          //                 //   borderRadius: BorderRadius.circular(15),
          //                 //   // shape: BoxShape.circle
          //                 // ),
          //                 child: Center(
          //                     child: Icon(
          //                   Icons.payment,
          //                   color: mainFontColor,
          //                 )),
          //               ),
          //               SizedBox(
          //                 width: 20,
          //               ),
          //               Expanded(
          //                 child: Container(
          //                   padding: const EdgeInsets.all(20),
          //                   child: TextField(
          //                       controller: Date1,
          //                       decoration: const InputDecoration(
          //                         border: OutlineInputBorder(),
          //                         labelText: 'วันที่เริ่มต้นลา',
          //                       ),
          //                       onTap: () async {
          //                         DateTime? pickeddate = await showDatePicker(
          //                             context: context,
          //                             initialDate: DateTime.now(),
          //                             firstDate: DateTime.now(),
          //                             lastDate: DateTime(2101));

          //                         if (pickeddate != null) {
          //                           Date1.text = DateFormat('yyyy-MM-dd')
          //                               .format(pickeddate);
          //                         }
          //                       }),
          //                 ),
          //               ),
          //               Expanded(
          //                 child: Container(
          //                   padding: const EdgeInsets.all(20),
          //                   child: TextField(
          //                       controller: Date2,
          //                       decoration: const InputDecoration(
          //                         border: OutlineInputBorder(),
          //                         labelText: 'วันที่สิ้นสุดการลา',
          //                       ),
          //                       onTap: () async {
          //                         DateTime? pickeddate = await showDatePicker(
          //                             context: context,
          //                             initialDate: DateTime.now(),
          //                             firstDate: DateTime.now(),
          //                             lastDate: DateTime(2101));

          //                         if (pickeddate != null) {
          //                           Date2.text = DateFormat('yyyy-MM-dd')
          //                               .format(pickeddate);
          //                         }
          //                       }),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          // Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         margin: EdgeInsets.only(
          //           top: 10,
          //           left: 25,
          //           right: 25,
          //         ),
          //         decoration: BoxDecoration(
          //             color: white,
          //             borderRadius: BorderRadius.circular(25),
          //             boxShadow: [
          //               BoxShadow(
          //                 color: grey.withOpacity(0.03),
          //                 spreadRadius: 10,
          //                 blurRadius: 3,
          //                 // changes position of shadow
          //               ),
          //             ]),
          //         child: Padding(
          //           padding: const EdgeInsets.only(
          //               top: 10, bottom: 20, right: 20, left: 20),
          //           child: Row(
          //             children: [
          //               Container(
          //                 width: 50,
          //                 height: 50,
          //                 // decoration: BoxDecoration(
          //                 //   color: arrowbgColor,
          //                 //   borderRadius: BorderRadius.circular(15),
          //                 //   // shape: BoxShape.circle
          //                 // ),
          //                 child: Center(
          //                     child: Icon(
          //                   Icons.payment,
          //                   color: mainFontColor,
          //                 )),
          //               ),
          //               SizedBox(
          //                 width: 20,
          //               ),
          //               Expanded(
          //                 child: Container(
          //                   padding: const EdgeInsets.all(20),
          //                   child: TextField(
          //                     controller: DateText,
          //                     decoration: const InputDecoration(
          //                       border: OutlineInputBorder(),
          //                       labelText: 'เหตุผลการลา',
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          // Container(
          //   height: 50,
          //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          //   child: ElevatedButton(
          //       child: const Text('ยืนยันการลางาน'),
          //       onPressed: _showAlertWorkOut),
          // ),

          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: 325,
                  height: 325,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://res.cloudinary.com/dic3o7vzw/image/upload/v1673927487/avatars/cropped_uxagcn.jpg"),
                          fit: BoxFit.cover)),
                ),
              ),
            ]),
          ),
        ],
      ),
    ));
  }
}

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
      child: Text('ลางานสำเร็จ รออนุมัติจาก HR ' + '',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 180, 45),
              fontSize: 48,
              fontWeight: FontWeight.bold)),
    );
  }
}

class ErrorOut extends StatelessWidget {
  final String webViewUrl;

  const ErrorOut(this.webViewUrl, {Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return const Center(
      child: Text('ลางานสำเร็จไม่สำเร็จ กรุณาตรวจสอบข้อมูลให้ถูกต้อง ' + '',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 226, 30, 0),
              fontSize: 48,
              fontWeight: FontWeight.bold)),
    );
  }
}

class WorkOutNo extends StatelessWidget {
  final String webViewUrl;

  const WorkOutNo(this.webViewUrl, {Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return const Center(
      child: Text(
          'จำนวนสิทธิ์การลาของคุณเกินกว่ากำหนด กรุณาตรวจสอบข้อมูลสิทธิ์การลาของคุณ' +
              '',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 226, 30, 0),
              fontSize: 48,
              fontWeight: FontWeight.bold)),
    );
  }
}
