import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_card/Database/DatabaseSirvecs.dart';
import 'package:job_card/Other/Loading.dart';

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
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                  title: Text(snapshot.data!.docs[index].data()['']),
                );
              },
            );
          }
        },
      )),
    );
  }
}
