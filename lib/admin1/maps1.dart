import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



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

class _TransectionPageState extends State<TransectionPage> {

  
  String dropdownvalue = 'ลาป่วย';
  // List of items in our dropdown menu
  var items = [
    'ลาป่วย',
    'ลาเป็นไข้',
    'ลาแล้ว',
    'ลาเลย',
    'ลานะ',
  ];

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
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
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
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("ระบบลางาน",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: mainFontColor,
                    )),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("วันนี้วันที่ :" + datetime2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: mainFontColor,
                    )),
              ],
            ),
          ),

///////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
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
                        top: 10, bottom: 20, right: 20, left: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          // decoration: BoxDecoration(
                          //   color: arrowbgColor,
                          //   borderRadius: BorderRadius.circular(15),
                          //   // shape: BoxShape.circle
                          // ),
                          child: Center(
                              child: Icon(
                            Icons.payment,
                            color: mainFontColor,
                          )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                                controller: Date1,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'วันที่เริ่มต้นลา',
                                ),
                                onTap: () async {
                                  DateTime? pickeddate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2101));

                                  if (pickeddate != null) {
                                    Date1.text = DateFormat('yyyy-MM-dd')
                                        .format(pickeddate);
                                  }
                                }),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                                controller: Date2,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'วันที่สิ้นสุดการลา',
                                ),
                                onTap: () async {
                                  DateTime? pickeddate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2101));

                                  if (pickeddate != null) {
                                    Date2.text = DateFormat('yyyy-MM-dd')
                                        .format(pickeddate);
                                  }
                                }),
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
                  margin: EdgeInsets.only(
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
                        top: 10, bottom: 20, right: 20, left: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          // decoration: BoxDecoration(
                          //   color: arrowbgColor,
                          //   borderRadius: BorderRadius.circular(15),
                          //   // shape: BoxShape.circle
                          // ),
                          child: Center(
                              child: Icon(
                            Icons.payment,
                            color: mainFontColor,
                          )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: DropdownButton(
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue.toString();
                                print(dropdownvalue);
                              });
                            },
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
                  margin: EdgeInsets.only(
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
                        top: 10, bottom: 20, right: 20, left: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          // decoration: BoxDecoration(
                          //   color: arrowbgColor,
                          //   borderRadius: BorderRadius.circular(15),
                          //   // shape: BoxShape.circle
                          // ),
                          child: Center(
                              child: Icon(
                            Icons.payment,
                            color: mainFontColor,
                          )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                              controller: DateText,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'เหตุผลการลา',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: buttoncolor, borderRadius: BorderRadius.circular(25)),
            child: Center(
              child: Text(
                "ยืนยันการลา",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
