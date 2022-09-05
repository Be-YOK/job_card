import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:job_card/Screens/MainPage.dart';
import 'package:job_card/Screens/NewJobCard.dart';
import 'package:job_card/Screens/Search.dart';
import 'package:job_card/Screens/WaitList.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const First());
}

class First extends StatelessWidget {
  const First({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job_Card',
      // ignore: prefer_const_constructors
      home: JobCard(),
    );
  }
}

class JobCard extends StatefulWidget {
  const JobCard({Key? key}) : super(key: key);

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  const SliverAppBar(
                    bottom: TabBar(tabs: [
                      Tab(text: 'جديد', icon: Icon(Icons.fiber_new_outlined)),
                      Tab(text: 'بحث', icon: Icon(Icons.search)),
                      Tab(
                          text: 'انتظار',
                          icon: Icon(Icons.watch_later_outlined)),
                    ]),
                    toolbarHeight: 10,
                  )
                ];
              },
              body: const TabBarView(children: [
                NewJobCard(),
                Search(),
                WaitList(),
              ]),
            )),
      );
}



// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return const NewJobCard();
//   }
// }
