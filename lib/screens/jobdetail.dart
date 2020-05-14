import 'package:flutter/material.dart';
import 'package:ungdaily/models/jobdairy_model.dart';
import 'package:ungdaily/screens/officerlist.dart';

class JobDetail extends StatefulWidget {
  final JobDairyModel jobDairyModel;
  JobDetail({Key key, this.jobDairyModel}) : super(key: key);
  @override
  _JobDetailState createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  // Field
  JobDairyModel jobDairyModel;

  @override
  void initState() {
    super.initState();
    jobDairyModel = widget.jobDairyModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Job'),
      ),
      body: Column(
        children: <Widget>[
          Text(
            jobDairyModel.nameJob,
            style: TextStyle(fontSize: 24.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(jobDairyModel.detail),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('ผู้รับผิดชอบงาน'),
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => OfficerList(),
                  );
                  Navigator.push(context, route);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
