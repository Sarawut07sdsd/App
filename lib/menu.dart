import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/admin1/drawer_manager.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/admin1/hello.dart';
import 'package:flutter_application_1/admin1/counter.dart';
import 'package:flutter_application_1/admin1/the_mac.dart';
import 'package:flutter_application_1/admin1/maps.dart';
import 'package:flutter_application_1/admin1/maps1.dart';
import 'package:flutter_application_1/admin1/Tabla.dart';
import 'package:flutter_application_1/admin1/Tabla2.dart';
import 'package:flutter_application_1/admin1/addLa.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DrawerManagerProvider>(
        create: (_) => DrawerManagerProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'ลงเวลาเข้างาน & ออกงาน';
      case 1:
        return 'ลางาน';
      case 2:
        return 'ประวัติการเข้าทำงาน';
      case 3:
        return 'ประวัติลางาน';
      case 4:
        return 'ตำแหน่งบริษัท';
      case 5:
        return 'ออกจากระบบ';
      default:
        return 'ออกจากระบบ';
    }
  }

  Widget _getTitleWidget() {
    return Consumer<DrawerManagerProvider>(builder: (context, dmObj, _) {
      return Text(_getTitle(dmObj.selection));
    });
  }

  @override
  Widget build(BuildContext context) {
    const drawerSelections = [
      DailyPage(),
      TransectionPage(),
      Tabla1(),
      Tabla2(),
      CounterPage(),
      CounterPage(),
      MyApp(),
      TransectionPage2(),
    ];

    final manager = Provider.of<DrawerManagerProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(title: _getTitleWidget()),
        body: manager.body,
        drawer: DrawerManager(
          context,
          drawerElements: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.blueGrey,
                  size: 96,
                ),
              ),
            ),
            DrawerTile(
              context: context,
              leading: const Icon(Icons.hail_rounded),
              title: Text(_getTitle(0)),
              onTap: () async {
                // RUN A BACKEND Hello, Flutter OPERATION
        
              },
            ),
            DrawerTile(
              context: context,
              leading: const Icon(Icons.calculate),
              title: Text(_getTitle(1)),
              onTap: () async {
                // RUN A BACKEND Counter OPERATION
              },
            ),
            DrawerTile(
              context: context,
              leading: const Icon(Icons.calculate),
              title: Text(_getTitle(2)),
              onTap: () async {
                // RUN A BACKEND Counter OPERATION
              },
            ),
            DrawerTile(
              context: context,
              leading: const Icon(Icons.calculate),
              title: Text(_getTitle(3)),
              onTap: () async {
                // RUN A BACKEND Counter OPERATION
              },
            ),
            DrawerTile(
              context: context,
              leading: const Icon(Icons.calculate),
              title: Text(_getTitle(4)),
              onTap: () async {
                // RUN A BACKEND Counter OPERATION
              },
            ),
           
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
            DrawerTile(
              context: context,
              leading: const Icon(Icons.plus_one),
              title: Text(_getTitle(6)),
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MyApp();
                }));
              },
            ),
          ],
          tileSelections: drawerSelections,
        ));
  }
}
