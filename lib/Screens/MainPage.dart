import 'package:flutter/material.dart';
import 'package:job_card/Screens/NewJobCard.dart';
import 'package:job_card/Screens/Search.dart';
import 'package:job_card/Screens/WaitList.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('الصفحة الرئيسية'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 25, 15, 50),
              child: Image(
                image: AssetImage('assets/logo.png'),
                width: 130,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewJobCard()),
                      );
                    },
                    child: const Text(
                      'طلب عمل صيانة جديد',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Container(height: 40),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Search()),
                      );
                    },
                    child: const Text(
                      "بحث",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Container(height: 40),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WaitList()),
                      );
                    },
                    child: const Text(
                      "قائمة الانتظار",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
