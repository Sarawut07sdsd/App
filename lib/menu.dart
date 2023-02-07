import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/admin1/drawer_manager.dart';

import 'package:flutter_application_1/admin1/hello.dart';
import 'package:flutter_application_1/admin1/counter.dart';
import 'package:flutter_application_1/admin1/the_mac.dart';

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
        return 'หน้าแรก';
      case 1:
        return 'ลงเวลาเข้างาน';
      case 2:
        return 'ลางาน';
      case 3:
        return 'สิทธิ์การลางาน';
      case 4:
        return 'สิทธิ์เข้างาน';
      case 5:
        return 'ตำแหน่งบริษัท';
      case 6:
        return 'ออกจากระบบ';
      default:
        return '';
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
      HelloPage(),
      CounterPage(),
      TheMACPage(),
      TheMACPage(),
      TheMACPage(),
      TheMACPage(),
      TheMACPage(),
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
            DrawerTile(
              context: context,
              leading: const Icon(Icons.calculate),
              title: Text(_getTitle(5)),
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
                // RUN A BACKEND Signup OPERATION
              },
            ),
          ],
          tileSelections: drawerSelections,
        ));
  }
}
