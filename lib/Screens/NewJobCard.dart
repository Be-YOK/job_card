import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:intl/intl.dart';
import 'package:job_card/Database/DatabaseSirvecs.dart';
import 'package:job_card/Other/HandWriting.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب عمل صيانة جديد'),
        centerTitle: true,
      ),
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
                                      print('${info[index]} = $value');
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
                                    builder: (context) => const HandWriting()),
                              );

                              setState(() {
                                details = result;
                              });
                              print('details = $details');
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HandWriting()),
                              );
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
                                    primary: Colors.blue),
                                onPressed: () async {
                                  await databaseSirvecs
                                      .createJobCard(
                                          data[0],
                                          DateTime.now(),
                                          '',
                                          true,
                                          data[2],
                                          data[1],
                                          data[4],
                                          data[6],
                                          data[3],
                                          data[5],
                                          data[7],
                                          '')
                                      .then((result) async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('تمت العملية بنجاح'),
                                        content: const Text(
                                            'تم حفظ طلب عمل لاصيانة'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainPage()),
                                              );
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).catchError((error) async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('حدث خطأ'),
                                        content: const Text(
                                            'تحقق من اتصال الانترنت'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                                child: const Text(
                                  'انتهى',
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
                                  var result = await databaseSirvecs
                                      .createJobCard(
                                          data[0],
                                          DateTime.now(),
                                          '',
                                          false,
                                          data[2],
                                          data[1],
                                          data[4],
                                          data[6],
                                          data[3],
                                          data[5],
                                          data[7],
                                          '')
                                      .then((result) async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('تمت العملية بنجاح'),
                                        content: const Text(
                                            'تم حفظ طلب عمل لاصيانة'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainPage()),
                                              );
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).catchError((error) async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('حدث خطأ'),
                                        content: const Text(
                                            'تحقق من اتصال الانترنت'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
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
    );
  }
}
