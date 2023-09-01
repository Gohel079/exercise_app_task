// To parse this JSON data, do
//
//     final recommendedTimeModel = recommendedTimeModelFromJson(jsonString);

import 'dart:convert';

RecommendedTimeModel recommendedTimeModelFromJson(String str) => RecommendedTimeModel.fromJson(json.decode(str));

String recommendedTimeModelToJson(RecommendedTimeModel data) => json.encode(data.toJson());

class RecommendedTimeModel {
  String? message;
  Data? data;
  bool? success;

  RecommendedTimeModel({
    this.message,
    this.data,
    this.success,
  });

  RecommendedTimeModel copyWith({
    String? message,
    Data? data,
    bool? success,
  }) =>
      RecommendedTimeModel(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
      );

  factory RecommendedTimeModel.fromJson(Map<String, dynamic> json) => RecommendedTimeModel(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "success": success,
  };
}

class Data {
  String? id;
  WorkingHours? workingHours;
  dynamic activityLevelId;
  List<String>? activeBreaks;
  String? email;
  String? userType;
  String? firstName;
  String? lastName;
  String? username;
  dynamic? image;
  dynamic? birthDate;
  dynamic? weight;
  dynamic? height;
  String? gender;
  String? companyId;
  String? department;
  int? unlockedActivityLevel;
  dynamic? focus;
  String? companyName;

  Data({
    this.id,
    this.workingHours,
    this.activityLevelId,
    this.activeBreaks,
    this.email,
    this.userType,
    this.firstName,
    this.lastName,
    this.username,
    this.image,
    this.birthDate,
    this.weight,
    this.height,
    this.gender,
    this.companyId,
    this.department,
    this.unlockedActivityLevel,
    this.focus,
    this.companyName,
  });

  Data copyWith({
    String? id,
    WorkingHours? workingHours,
    dynamic activityLevelId,
    List<String>? activeBreaks,
    String? email,
    String? userType,
    String? firstName,
    String? lastName,
    String? username,
    dynamic? image,
    dynamic? birthDate,
    dynamic? weight,
    dynamic height,
    String? gender,
    String? companyId,
    String? department,
    int? unlockedActivityLevel,
    dynamic? focus,
    String? companyName,
  }) =>
      Data(
        id: id ?? this.id,
        workingHours: workingHours ?? this.workingHours,
        activityLevelId: activityLevelId ?? this.activityLevelId,
        activeBreaks: activeBreaks ?? this.activeBreaks,
        email: email ?? this.email,
        userType: userType ?? this.userType,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        username: username ?? this.username,
        image: image ?? this.image,
        birthDate: birthDate ?? this.birthDate,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        gender: gender ?? this.gender,
        companyId: companyId ?? this.companyId,
        department: department ?? this.department,
        unlockedActivityLevel: unlockedActivityLevel ?? this.unlockedActivityLevel,
        focus: focus ?? this.focus,
        companyName: companyName ?? this.companyName,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    workingHours: json["working_hours"] == null ? null : WorkingHours.fromJson(json["working_hours"]),
    activityLevelId: json["activity_level_id"],
    activeBreaks: json["active_breaks"] == null ? [] : List<String>.from(json["active_breaks"]!.map((x) => x)),
    email: json["email"],
    userType: json["user_type"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    image: json["image"],
    birthDate: json["birth_date"],
    weight: json["weight"],
    height: json["height"],
    gender: json["gender"],
    companyId: json["company_id"],
    department: json["department"],
    unlockedActivityLevel: json["unlocked_activity_level"],
    focus: json["focus"],
    companyName: json["company_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "working_hours": workingHours?.toJson(),
    "activity_level_id": activityLevelId,
    "active_breaks": activeBreaks == null ? [] : List<dynamic>.from(activeBreaks!.map((x) => x)),
    "email": email,
    "user_type": userType,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "image": image,
    "birth_date": birthDate,
    "weight": weight,
    "height": height,
    "gender": gender,
    "company_id": companyId,
    "department": department,
    "unlocked_activity_level": unlockedActivityLevel,
    "focus": focus,
    "company_name": companyName,
  };
}

class WorkingHours {
  Fri? mon;
  Fri? tue;
  Fri? wed;
  Fri? thu;
  Fri? fri;
  Fri? sat;

  WorkingHours({
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.sat,
  });

  WorkingHours copyWith({
    Fri? mon,
    Fri? tue,
    Fri? wed,
    Fri? thu,
    Fri? fri,
    Fri? sat,
  }) =>
      WorkingHours(
        mon: mon ?? this.mon,
        tue: tue ?? this.tue,
        wed: wed ?? this.wed,
        thu: thu ?? this.thu,
        fri: fri ?? this.fri,
        sat: sat ?? this.sat,
      );

  factory WorkingHours.fromJson(Map<String, dynamic> json) => WorkingHours(
    mon: json["MON"] == null ? null : Fri.fromJson(json["MON"]),
    tue: json["TUE"] == null ? null : Fri.fromJson(json["TUE"]),
    wed: json["WED"] == null ? null : Fri.fromJson(json["WED"]),
    thu: json["THU"] == null ? null : Fri.fromJson(json["THU"]),
    fri: json["FRI"] == null ? null : Fri.fromJson(json["FRI"]),
    sat: json["SAT"] == null ? null : Fri.fromJson(json["SAT"]),
  );

  Map<String, dynamic> toJson() => {
    "MON": mon?.toJson(),
    "TUE": tue?.toJson(),
    "WED": wed?.toJson(),
    "THU": thu?.toJson(),
    "FRI": fri?.toJson(),
    "SAT": sat?.toJson(),
  };
}

class Fri {
  String? startTime;
  String? endTime;

  Fri({
    this.startTime,
    this.endTime,
  });

  Fri copyWith({
    String? startTime,
    String? endTime,
  }) =>
      Fri(
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );

  factory Fri.fromJson(Map<String, dynamic> json) => Fri(
    startTime: json["start_time"],
    endTime: json["end_time"],
  );

  Map<String, dynamic> toJson() => {
    "start_time": startTime,
    "end_time": endTime,
  };
}
