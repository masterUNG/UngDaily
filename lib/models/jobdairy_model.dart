class JobDairyModel {

  String nameJob, detail;

  JobDairyModel(this.nameJob, this.detail);

  JobDairyModel.fromJSON(Map<String, dynamic> map){
    nameJob = map['NameJob'];
    detail = map['Detail'];
  }

  
}