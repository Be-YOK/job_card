import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:intl/intl.dart';

class NewJobCard extends StatefulWidget {
  const NewJobCard({Key? key}) : super(key: key);

  @override
  State<NewJobCard> createState() => _NewJobCardState();
}

class _NewJobCardState extends State<NewJobCard> {
  List<String> info = [
    'اسم العميل',
    'رقم التلفون',
    'نوع السيارة',
    'رقم اللوحة',
    'عدد السلندرات',
    'عداد السيارة',
    'رقم الشاصي'
  ];

  String formattedDate =
      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

  HandSignatureControl control = HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

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
                      CustomPaint(
                        painter: DebugSignaturePainterCP(
                          control: control,
                          cp: false,
                          cpStart: false,
                          cpEnd: false,
                        ),
                      ),
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
