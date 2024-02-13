import 'package:cloud_firestore/cloud_firestore.dart';
class Person {
  // personal info
  String? uid;
  String? imageProfile;
  String? name;
  String? email;
  String? password;
  int? age;
  String? phoneNo;
  String? city;
  String? country;
  String? profileHeading;
  String? lookingForInaPartner;
  int? publishedDateTime;

  // Appearance
  String? height;
  String? weight;
  String? bodyType;

  // Life style
  String? drink;
  String? smoke;
  String? martialStatus;
  String? haveChildren;
  String? noOfChildren;
  String? profession;
  String? employmentStatus;
  String? income;
  String? livingSituation;
  String? willingToRelocate;
  String? relationshipYouAreLookingFor;

  // Background
  String? nationality;
  String? education;
  String? languageSpoken;
  String? religion;
  String? ethnicity;

  Person({
    this.uid,
    this.imageProfile,
    this.name,
    this.email,
    this.password,
    this.age,
    this.phoneNo,
    this.city,
    this.country,
    this.profileHeading,
    this.lookingForInaPartner,
    this.publishedDateTime,
    this.height,
    this.weight,
    this.bodyType,
    this.drink,
    this.smoke,
    this.martialStatus,
    this.haveChildren,
    this.noOfChildren,
    this.profession,
    this.employmentStatus,
    this.income,
    this.livingSituation,
    this.willingToRelocate,
    this.relationshipYouAreLookingFor,
    this.nationality,
    this.education,
    this.languageSpoken,
    this.religion,
    this.ethnicity,
  });

  static Person formdataSnapshot(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return Person(
      uid: dataSnapshot["uid"],
      name: dataSnapshot["name"],
      email: dataSnapshot["email"],
      password: dataSnapshot["password"],
      imageProfile: dataSnapshot["imageProfile"],
      age: dataSnapshot["age"],
      phoneNo: dataSnapshot["phoneNo"],
      city: dataSnapshot["city"],
      country: dataSnapshot["country"],
      profileHeading: dataSnapshot["profileHeading"],
      lookingForInaPartner: dataSnapshot["lookingForInaPartner"],
      publishedDateTime: dataSnapshot["publishedDateTime"],
      height: dataSnapshot["height"],
      weight: dataSnapshot["weight"],
      bodyType: dataSnapshot["bodyType"],
      drink: dataSnapshot["drink"],
      smoke: dataSnapshot["smoke"],
      martialStatus: dataSnapshot["martialStatus"],
      haveChildren: dataSnapshot["haveChildren"],
      noOfChildren: dataSnapshot["noOfChildren"],
      profession: dataSnapshot["profession"],
      employmentStatus: dataSnapshot["employmentStatus"],
      income: dataSnapshot["income"],
      livingSituation: dataSnapshot["livingSituation"],
      willingToRelocate: dataSnapshot["willingToRelocate"],
      relationshipYouAreLookingFor: dataSnapshot["relationshipYouAreLookingFor"],
      nationality: dataSnapshot["nationality"],
      education: dataSnapshot["education"],
      languageSpoken: dataSnapshot["languageSpoken"],
      religion: dataSnapshot["religion"],
      ethnicity: dataSnapshot["ethnicity"],
    );
  }

  Map<String, dynamic> toJson()=>
      {
        "uid":uid,
        "imageProfile": imageProfile,
        "name": name,
        "email": email,
        "password": password,
        "age": age,
        "phoneNo": phoneNo,
        "city": city,
        "country": country,
        "profileHeading": profileHeading,
        "lookingForInaPartner": lookingForInaPartner,
        "publishedDateTime": publishedDateTime,
        "height": height,
        "weight": weight,
        "bodyType": bodyType,
        "drink": drink,
        "smoke": smoke,
        "martialStatus": martialStatus,
        "haveChildren": haveChildren,
        "noOfChildren": noOfChildren,
        "profession": profession,
        "employmentStatus": employmentStatus,
        "income": income,
        "livingSituation": livingSituation,
        "willingToRelocate": willingToRelocate,
        "relationshipYouAreLookingFor": relationshipYouAreLookingFor,
        "nationality": nationality,
        "education": education,
        "languageSpoken": languageSpoken,
        "religion": religion,
        "ethnicity": ethnicity,
  };
}