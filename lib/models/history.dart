class Historylist {
  int? id;
  String? studentId;
  String? requestType;
  String? reasonType;
  String? fromDate;
  String? fromTime;
  String? toDate;
  String? toTime;
  String? status;
  String? principalStatus;
  String? parentsStatus;
  String? statusOpen;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? statusText;
  String? section;

  Historylist(
      {this.id,
      this.studentId,
      this.requestType,
      this.reasonType,
      this.fromDate,
      this.fromTime,
      this.toDate,
      this.toTime,
      this.status,
      this.principalStatus,
      this.parentsStatus,
      this.statusOpen,
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.lastName,
      this.statusText,
      this.section});

  Historylist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'].toString();
    requestType = json['request_type'].toString();
    reasonType = json['reason_type'].toString();
    fromDate = json['from_date'].toString();
    fromTime = json['from_time'];
    toDate = json['to_date'];
    toTime = json['to_time'];
    status = json['status'].toString();
    principalStatus = json['principal_status'];
    parentsStatus = json['parents_status'];
    statusOpen = json['status_open'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    statusText = json['status_text'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_id'] = this.studentId;
    data['request_type'] = this.requestType;
    data['reason_type'] = this.reasonType;
    data['from_date'] = this.fromDate;
    data['from_time'] = this.fromTime;
    data['to_date'] = this.toDate;
    data['to_time'] = this.toTime;
    data['status'] = this.status;
    data['principal_status'] = this.principalStatus;
    data['parents_status'] = this.parentsStatus;
    data['status_open'] = this.statusOpen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['status_text'] = this.statusText;
    data['section'] = this.section;

    return data;
  }
}
