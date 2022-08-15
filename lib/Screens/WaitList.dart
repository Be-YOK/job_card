import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_card/Database/DatabaseSirvecs.dart';
import 'package:job_card/Other/Loading.dart';
import 'package:job_card/Screens/JobCardPage.dart';

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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: databaseSirvecs.getAllWaitingJobCards(),
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
                      ListTile(
                        title: Text(
                          '${snapshot.data!.docs[index].data()['name']} \nmobile: ${snapshot.data!.docs[index].data()['phone']} \n${snapshot.data!.docs[index].data()['model']} - #${snapshot.data!.docs[index].data()['carNo']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(DateFormat('yyyy-MM-dd – kk:mm').format(
                            snapshot.data!.docs[index]
                                .data()['createdAt']
                                .toDate())),
                        leading: const Icon(Icons.car_crash),
                        iconColor: Colors.red,
                        tileColor: Colors.grey,
                        onTap: () {
                          String id = snapshot.data!.docs[index].data()['id'];
                          String title = '${snapshot.data!.docs[index].data()['model']} - #${snapshot.data!.docs[index].data()['carNo']}';

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JobCardPage(id: id, title: title)),
                          );
                        },
                      ),
                      Container(height: 10)
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
