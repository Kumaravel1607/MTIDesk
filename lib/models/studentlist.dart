class Studentlist {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? dob;
  String? section;
  String? totalLeaveApproved;

  Studentlist(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNo,
      this.dob,
      this.section,
      this.totalLeaveApproved});

  Studentlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    dob = json['dob'];
    section = json['section'];
    totalLeaveApproved = json['total_leave_approved'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['dob'] = this.dob;
    data['section'] = this.section;
    data['total_leave_approved'] = this.totalLeaveApproved;
    return data;
  }
}
