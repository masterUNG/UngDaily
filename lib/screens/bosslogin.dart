import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungdaily/models/jobdairy_model.dart';
import 'package:ungdaily/screens/authen.dart';
import 'package:ungdaily/screens/jobdetail.dart';

class BossLogin extends StatefulWidget {
  @override
  _BossLoginState createState() => _BossLoginState();
}

class _BossLoginState extends State<BossLogin> {
  // Field
  String uidLogin, nameBoss;
  List<JobDairyModel> jobDairyModels = List();

  @override
  void initState() {
    super.initState();
    findUid();
  }

  Future<Null> findJob() async {
    if (jobDairyModels.length != 0) {
      jobDairyModels.clear();
    }

    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Job');
    await collectionReference
        .document(uidLogin)
        .collection('JobDairy')
        .snapshots()
        .listen((event) {
      List<DocumentSnapshot> list = event.documents;
      for (var map in list) {
        JobDairyModel jobDairyModel = JobDairyModel.fromJSON(map.data);
        print('NameJob = ${jobDairyModel.nameJob}');
        setState(() {
          jobDairyModels.add(jobDairyModel);
        });
      }
    });
  }

  Future<Null> findUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.currentUser().then((value) async {
      uidLogin = value.uid;
      findBoss();
      findJob();
    });
  }

  Future<Null> findBoss() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Job');
    await collectionReference.document(uidLogin).snapshots().listen((event) {
      var object = event.data;
      print('object = $object');
      setState(() {
        nameBoss = object['NameBoss'];
      });
    });
  }

  Future<Null> mySignOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut().then((value) {
      MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => Authen(),
      );
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameBoss == null ? 'Boss' : '$nameBoss Login'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => mySignOut(),
          )
        ],
      ),
      body: jobDairyModels.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : jobListView(),
    );
  }

  ListView jobListView() {
    return ListView.builder(
      itemCount: jobDairyModels.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => JobDetail(
              jobDairyModel: jobDairyModels[index],
            ),
          );
          Navigator.push(context, route);
        },
        child: Card(
          color: index % 2 == 0 ? Colors.blue.shade50 : Colors.blue.shade200,
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      jobDairyModels[index].nameJob,
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(jobDairyModels[index].detail),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
