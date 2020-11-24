import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ResumeDatabase {
  var uid = "JkG0HvAYMotUg8rMz6ug";
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future addSkill(String skill) async {
    var map = {"type": "skills", "information": skill};
    await usersCollection.doc(uid).collection('Resume').add(map);
    QuerySnapshot snapshot =
        await usersCollection.doc(uid).collection('Resume').get();
    snapshot.docs.forEach((element) {
      element['type'] == 'skills'
          ? print('${element['information']} is skill')
          : print('not');
    });
  }

  Future addInterest(String interest) async {
    var map = {"type": "interset", "information": interest};
    await usersCollection.doc(uid).collection('Resume').add(map);
    QuerySnapshot snapshot =
        await usersCollection.doc(uid).collection('Resume').get();
    snapshot.docs.forEach((element) {
      element['type'] == 'interest'
          ? print('${element['information']} is skill')
          : print('not');
    });
  }

  Future addExperienceDetials(
      String title,
      String type,
      String company,
      String location,
      String startDate,
      String endDate,
      String description,
      File image) async {
    var images = '';
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);

    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      String firebaseImageLink = downloadUrl.toString();
      images = firebaseImageLink;
    }
    var map = {
      "type": "experence",
      "company": company,
      "location": location,
      "startDate": startDate,
      "endDate": endDate,
      "description": description,
      "image": images
    };
    await usersCollection.doc(uid).collection('Resume').add(map);
  }

  Future addEducation(
      String school,
      String degree,
      String field,
      String startDate,
      String endDate,
      String grade,
      String description,
      String activity,
      File image) async {
    var images = '';
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);

    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      String firebaseImageLink = downloadUrl.toString();
      images = firebaseImageLink;
    }
    var map = {
      "type": "education",
      "school": school,
      "degree": degree,
      "field": field,
      "startDate": startDate,
      "endDate": endDate,
      "grade": grade,
      "description": description,
      "activity": activity,
      "image": images
    };

    await usersCollection.doc(uid).collection('Resume').add(map);
  }

  Future addAchivement(String title, String code, String description,
      String link, String date, File image) async {
    var images = '';
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);

    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      String firebaseImageLink = downloadUrl.toString();
      images = firebaseImageLink;
    }
    var map = {
      "type": "achievement",
      "title": title,
      "code": code,
      "description": description,
      "link": link,
      "date": date,
      "image": images
    };
    await usersCollection.doc(uid).collection('Resume').add(map);
  }

  Future<QuerySnapshot> getData() async {
    return await usersCollection.doc(uid).collection('Resume').get();
  }


  Future<QuerySnapshot> getUserDetail()async{
     return await usersCollection.doc(uid).collection('PersonalInfo').get();
  }
}
