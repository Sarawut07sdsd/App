import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

class MyAPI2 {
  static Future<List<dynamic>> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    final response = await http.get(Uri.parse(
        'http://localhost/1Projest/leave_system/leave_system/apiApp/Tabla2.php?str=laYa&Emp_id=' +
            user.toString()));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class MyAPI3 {
  static Future<List<dynamic>> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    final response = await http.get(Uri.parse(
        'http://localhost/1Projest/leave_system/leave_system/apiApp/Tabla2.php?str=laNo&Emp_id=' +
            user.toString()));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class MyAPI4 {
  static Future<List<dynamic>> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    final response = await http.get(Uri.parse(
        'http://localhost/1Projest/leave_system/leave_system/apiApp/Tabla2.php?str=lalo&Emp_id=' +
            user.toString()));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Tabla2 extends StatelessWidget {
  const Tabla2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ข้อมูลการลางาน',
      home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text: 'สิทธิ์การลางานคงเหลือ'),
                  Tab(text: 'อนุมัติแล้ว'),
                  Tab(text: 'ไม่อนุมัติ'),
                  Tab(text: 'รออนุมัติ'),
                ],
              ),
              title: Text('ข้อมูลการลางาน'),
            ),
            body: TabBarView(
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
                          ],
                          rows: data
                              .map((user) => DataRow(cells: [
                                    DataCell(Text(user['num'].toString())),
                                    DataCell(Text(user['Type_name'])),
                                    DataCell(
                                        Text(user['leave_maximum'].toString())),
                                    DataCell(
                                        Text(user['datesomSum'].toString())),
                                    DataCell(Text(user['sum'].toString())),
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
                  padding: EdgeInsets.all(16.0),
                  child: FutureBuilder<List<dynamic>>(
                    future: MyAPI2.fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  'รหัสลางาน : ' +
                                      data[index]['Leave_id'].toString() +
                                      ': ประเภทลางาน : ' +
                                      data[index]['Type_name'] +
                                      ': วันที่ทำรายการ : ' +
                                      data[index]['Leave_date'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8.0),
                                    Text(
                                      'ชื่อผู้ใช้งาน ' +
                                          data[index]['Emp_name'],
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      'ลาวันที่  :' +
                                          data[index]['Leave_start']
                                              .toString() +
                                          ': ถึงวันที่ :' +
                                          data[index]['Leave_end'].toString(),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      'วันที่อนุมัติ : ' +
                                          data[index]['App_date'].toString() +
                                          ': สถานะ : ' +
                                          data[index]['text'],
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 180, 45),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
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
                  padding: EdgeInsets.all(16.0),
                  child: FutureBuilder<List<dynamic>>(
                    future: MyAPI3.fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  'รหัสลางาน : ' +
                                      data[index]['Leave_id'].toString() +
                                      ': ประเภทลางาน : ' +
                                      data[index]['Type_name'] +
                                      ': วันที่ทำรายการ : ' +
                                      data[index]['Leave_date'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8.0),
                                    Text(
                                      'ชื่อผู้ใช้งาน ' +
                                          data[index]['Emp_name'],
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      'ลาวันที่  :' +
                                          data[index]['Leave_start']
                                              .toString() +
                                          ': ถึงวันที่ :' +
                                          data[index]['Leave_end'].toString(),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      'วันที่อนุมัติ : ' +
                                          data[index]['App_date'].toString() +
                                          ': สถานะ : ' +
                                          data[index]['text'],
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 247, 11, 11),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
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
                  padding: EdgeInsets.all(16.0),
                  child: FutureBuilder<List<dynamic>>(
                    future: MyAPI4.fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  'รหัสลางาน : ' +
                                      data[index]['Leave_id'].toString() +
                                      ': ประเภทลางาน : ' +
                                      data[index]['Type_name'] +
                                      ': วันที่ทำรายการ : ' +
                                      data[index]['Leave_date'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8.0),
                                    Text(
                                      'ชื่อผู้ใช้งาน ' +
                                          data[index]['Emp_name'],
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      'ลาวันที่  :' +
                                          data[index]['Leave_start']
                                              .toString() +
                                          ': ถึงวันที่ :' +
                                          data[index]['Leave_end'].toString(),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      'วันที่อนุมัติ : ' +
                                          data[index]['App_date'].toString() +
                                          ': สถานะ : ' +
                                          data[index]['text'],
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 31, 45, 244),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
