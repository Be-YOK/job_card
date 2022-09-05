import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:intl/intl.dart';
import 'package:job_card/Database/DatabaseSirvecs.dart';
import 'package:job_card/HandWriting/HandWriting.dart';
import 'package:job_card/Other/AlertMessages/AlertMessage.dart';
import 'package:job_card/Screens/MainPage.dart';

class NewJobCard extends StatefulWidget {
  const NewJobCard({Key? key}) : super(key: key);

  @override
  State<NewJobCard> createState() => _NewJobCardState();
}

class _NewJobCardState extends State<NewJobCard> {
  List<String> info = [
    'رقم الكرت',
    'اسم العميل',
    'رقم التلفون',
    'نوع السيارة',
    'رقم اللوحة',
    'عدد السلندرات',
    'عداد السيارة',
    'رقم الشاصي'
  ];

  List data = ['', '', '', '', '', '', '', '', '', '', ''];

  var details;
  var signature;

  String formattedDate =
      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

  DatabaseSirvecs databaseSirvecs = DatabaseSirvecs();

  //var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/logo.png'),
                      width: 50,
                    ),
                    Container(width: 30),
                    Column(
                      children: const [
                        Text(
                          'مجدي الرفاعي اس لاين',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Majdi Alrifai S Line',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(color: Colors.black),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: info.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  info[index],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all()),
                                child: TextFormField(
                                    onChanged: (value) {
                                      data[index] = value;
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none)),
                              ),
                              Container(height: 10)
                            ],
                          );
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'التاريخ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(height: 10),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          formattedDate,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(height: 10),
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'الخدمات المطلوبة',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 500,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HandWriting(
                                        date: formattedDate, type: 'details')),
                              );

                              setState(() {
                                details = result;
                              });
                            },
                            child: const Text(
                              'اضافة خدمات',
                              style: TextStyle(fontSize: 17),
                            )),
                      ),
                      Container(height: 10),
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Term 1 \u2022',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(height: 10),
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Term 2 \u2022',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(height: 10),
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Term 3 \u2022',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(height: 10),
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'توقيع العميل',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 500,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HandWriting(
                                        date: formattedDate,
                                        type: 'signature')),
                              );

                              setState(() {
                                signature = result;
                              });
                            },
                            child: const Text(
                              'اضافة توقيع',
                              style: TextStyle(fontSize: 17),
                            )),
                      ),
                      Container(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 170,
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 35, 252, 42)),
                                onPressed: () async {
                                  await databaseSirvecs
                                      .createJobCard(
                                          data[0],
                                          DateTime.now(),
                                          details,
                                          true,
                                          data[2],
                                          data[1],
                                          data[4],
                                          data[6],
                                          data[3],
                                          data[5],
                                          data[7],
                                          signature)
                                      .then((result) async {
                                    await alertMessage(
                                        context,
                                        'تمت العملية بنجاح',
                                        'تم حفظ طلب الصيانة');
                                  }).catchError((error) async {
                                    await alertMessage(context, 'حدث خطأ',
                                        'تحقق من اتصال الانترنت');
                                  });
                                },
                                child: const Text(
                                  'حفظ',
                                  style: TextStyle(fontSize: 17),
                                )),
                          ),
                          Container(width: 20),
                          SizedBox(
                            width: 170,
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                onPressed: () async {
                                  await databaseSirvecs
                                      .createJobCard(
                                          data[0],
                                          DateTime.now(),
                                          details,
                                          false,
                                          data[2],
                                          data[1],
                                          data[4],
                                          data[6],
                                          data[3],
                                          data[5],
                                          data[7],
                                          signature)
                                      .then((result) async {
                                    await alertMessage(
                                        context,
                                        'تمت العملية بنجاح',
                                        'تم حفظ طلب الصيانة');
                                  }).catchError((error) async {
                                    await alertMessage(context, 'حدث خطأ',
                                        'تحقق من اتصال الانترنت');
                                  });
                                },
                                child: const Text(
                                  'قائمة الانتظار',
                                  style: TextStyle(fontSize: 17),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     iconSize: 29,
      //     showUnselectedLabels: false,
      //     unselectedFontSize: 15,
      //     backgroundColor: Colors.blue,
      //     selectedItemColor: Colors.white,
      //     currentIndex: currentIndex,
      //     onTap: (index) => setState(() => currentIndex = index),
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.fiber_new_outlined),
      //         label: "جديد",
      //         backgroundColor: Colors.black,
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.search),
      //         label: "بحث",
      //         backgroundColor: Colors.black,
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.watch_later_outlined),
      //         label: "للإنهاء",
      //         backgroundColor: Colors.black,
      //       )
      //     ]),
    );
  }
}
