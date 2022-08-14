import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Database/DatabaseSirvecs.dart';
import '../Other/Loading.dart';

DatabaseSirvecs databaseSirvecs = DatabaseSirvecs();

class JobCardPage extends StatefulWidget {
  const JobCardPage({required this.id});

  final String id;

  @override
  State<JobCardPage> createState() => _JobCardPageState(id: id);
}

class _JobCardPageState extends State<JobCardPage> {
  
  final String id;

  _JobCardPageState({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الانتظار'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: databaseSirvecs.getJobCardById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('حدث خطأ. تحقق من الاتصال بالانترنت'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}