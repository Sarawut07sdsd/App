import 'package:flutter_application_1/admin1/maps.dart';
import 'package:flutter/material.dart';

class ErrorOut extends StatelessWidget {
  final String value;
  const ErrorOut(String? value) : value = value ?? '';
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    return const Center(
      child: Text( 'ทำรายการไม่สำเร็จ คุณได้ลงชื่อเข้างานสำหรับวันนี้ไปแล้ว จึงไม่สามารถบันทึกเวลาเข้างานซ้ำได้ !!',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 253, 20, 20),
              fontSize: 48,
              fontWeight: FontWeight.bold)),
    );
  }
}

class ErrorOut2 extends StatelessWidget {
  final String value;
  const ErrorOut2(String? value) : value = value ?? '';
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    return const Center(
      child: Text( 'ทำรายการไม่สำเร็จกรุณา อยู่ในระยะ 200 เมตร จากที่ตั้งบริษัท แล้วทำรายการใหม่อีกครั้ง  !!!!',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 253, 20, 20),
              fontSize: 48,
              fontWeight: FontWeight.bold)),
    );
  }
}


class ErrorOut3 extends StatelessWidget {
  final String value;
  const ErrorOut3(String? value) : value = value ?? '';
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    return const Center(
      child: Text( 'ทำรายการไม่สำเร็จ คุณต้องลงบันทึกเวลาเข้าทำงานก่อนจึงจะสามารถ บันทึกเวลาออกงานได้ !!',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 253, 20, 20),
              fontSize: 48,
              fontWeight: FontWeight.bold)),
    );
  }
}

class ErrorOut4 extends StatelessWidget {
  final String value;
  const ErrorOut4(String? value) : value = value ?? '';
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    return const Center(
      child: Text( 'ทำรายการไม่สำเร็จ คุณไม่ได้บันทึกเวลาออกงาน !! ',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 253, 20, 20),
              fontSize: 48,
              fontWeight: FontWeight.bold)),
    );
  }
}

