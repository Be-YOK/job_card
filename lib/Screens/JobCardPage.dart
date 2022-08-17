import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_card/Other/AlertMessages/AlertMessage.dart';
import 'package:job_card/Other/AlertMessages/TwoButtonsAlertMessage.dart';
import '../Database/DatabaseSirvecs.dart';
import '../Other/Loading.dart';

DatabaseSirvecs databaseSirvecs = DatabaseSirvecs();

class JobCardPage extends StatefulWidget {
  const JobCardPage({required this.id, required this.title});

  final String id;
  final String title;

  @override
  State<JobCardPage> createState() => _JobCardPageState(id: id, title: title);
}

class _JobCardPageState extends State<JobCardPage> {
  final String id;
  final String title;

  _JobCardPageState({required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  // TODO
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    Text('تعديل'),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  bool yes = await twoButtonsAlertMessage(
                      context,
                      'هل انت متأكد من الحذف؟',
                      'لا يمكن اعادة الطلبات المحذوفة');
                  if (yes) {
                    await databaseSirvecs
                        .deleteJobCard(id)
                        .then((result) async {
                      await alertMessage(
                          context, 'تمت العملية بنجاح', 'تم حذف طلب الصيانة');
                    });
                  }
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    Text('حذف'),
                  ],
                ),
              ),
            ],
          )
        ],
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'رقم الكرت',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(snapshot.data!.docs[index].data()['cardNo'],
                            style: const TextStyle(fontSize: 17)),
                        Container(height: 10),
                        const Text(
                          'اسم العميل',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(snapshot.data!.docs[index].data()['name'],
                            style: const TextStyle(fontSize: 17)),
                        Container(height: 10),
                        const Text(
                          'رقم التلفون',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(snapshot.data!.docs[index].data()['phone'],
                            style: const TextStyle(fontSize: 17)),
                        Container(height: 10),
                        const Text(
                          'نوع السيارة',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(snapshot.data!.docs[index].data()['model'],
                            style: const TextStyle(fontSize: 17)),
                        Container(height: 10),
                        const Text(
                          'رقم اللوحة',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(snapshot.data!.docs[index].data()['carNo'],
                            style: const TextStyle(fontSize: 17)),
                        Container(height: 10),
                        const Text(
                          'عدد السلندرات',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(snapshot.data!.docs[index].data()['nClyn'],
                            style: const TextStyle(fontSize: 17)),
                        Container(height: 10),
                        const Text(
                          'عداد السيارة',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(snapshot.data!.docs[index].data()['km'],
                            style: const TextStyle(fontSize: 17)),
                        Container(height: 10),
                        const Text(
                          'رقم الشاصي',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(snapshot.data!.docs[index].data()['chassiNo'],
                            style: const TextStyle(fontSize: 17)),
                        Container(height: 10),
                        const Text(
                          'التاريخ والوقت',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                            DateFormat('yyyy-MM-dd – kk:mm').format(snapshot
                                .data!.docs[index]
                                .data()['createdAt']
                                .toDate()),
                            style: const TextStyle(fontSize: 17)),
                        Container(height: 10),
                        const Text(
                          'التفاصيل',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Image.network(
                            snapshot.data!.docs[index].data()['sirveces']),
                        Container(height: 10),
                        const Text(
                          'توقيع العميل',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Image.network(
                            snapshot.data!.docs[index].data()['signature']),
                        Container(height: 15),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              bool finished = true;

                              String cardNo =
                                  snapshot.data!.docs[index].data()['cardNo'];
                              var createdAt = snapshot.data!.docs[index]
                                  .data()['createdAt']
                                  .toDate();
                              String sirveces =
                                  snapshot.data!.docs[index].data()['sirveces'];
                              bool done = true;
                              String phone =
                                  snapshot.data!.docs[index].data()['phone'];
                              String name =
                                  snapshot.data!.docs[index].data()['name'];
                              String carNo =
                                  snapshot.data!.docs[index].data()['carNo'];
                              String km =
                                  snapshot.data!.docs[index].data()['km'];
                              String model =
                                  snapshot.data!.docs[index].data()['model'];
                              String nClyn =
                                  snapshot.data!.docs[index].data()['nClyn'];
                              String chassiNo =
                                  snapshot.data!.docs[index].data()['chassiNo'];
                              String signature = snapshot.data!.docs[index]
                                  .data()['signature'];

                              await databaseSirvecs
                                  .updateJobCard(
                                      id,
                                      cardNo,
                                      createdAt,
                                      sirveces,
                                      done,
                                      phone,
                                      name,
                                      carNo,
                                      km,
                                      model,
                                      nClyn,
                                      chassiNo,
                                      signature)
                                  .then((result) async {
                                await alertMessage(context, 'تمت العمليه بنجاح',
                                    'تم الانتهاء من طلب عمل الصيانة');
                              }).catchError((error) async {
                                finished = false;
                                await alertMessage(context, 'حدث خطأ',
                                    'يرجى التحقق من اتصال الانترنت');
                              });

                              if (finished) {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              }
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.done),
                                  Container(width: 10),
                                  const Text('انتهى')
                                ]),
                          ),
                        ),
                      ],
                    ),
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
