import 'package:flutter/material.dart';
import 'package:job_card/Database/DatabaseSirveces.dart';
import 'package:job_card/Other/Loading.dart';
import 'package:job_card/main.dart';

DatabaseSirvecs databaseSirvecs = DatabaseSirvecs();

class WaitList extends StatefulWidget {
  const WaitList({Key? key}) : super(key: key);

  @override
  State<WaitList> createState() => _WaitListState();
}

class _WaitListState extends State<WaitList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الانتظار'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: StreamBuilder(
        stream: databaseSirvecs.getAllWaitingJobCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('حدث خطأ. تحقق من الاتصال بالانترنت'));
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.toString()),
                );
              },
            );
          }
        },
      )),
    );
  }
}
