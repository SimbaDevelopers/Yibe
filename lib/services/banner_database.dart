import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BannerDatabase {
  final CollectionReference bannerCollection =
      FirebaseFirestore.instance.collection('banner');
  Future<QuerySnapshot> getBanner() async {
    QuerySnapshot snapshot= await bannerCollection.get();
  return snapshot;
  }
}
