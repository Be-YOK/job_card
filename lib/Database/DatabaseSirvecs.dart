import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/JobCard.dart';

class DatabaseSirvecs {
  // Create
  Future createJobCard(
      String cardNo,
      DateTime createdAt,
      String sirveces,
      bool done,
      String phone,
      String name,
      String carNo,
      String km,
      String model,
      String nClyn,
      String chassiNo,
      String signature) async {
    final newJobCardDoc =
        FirebaseFirestore.instance.collection('JobCard').doc();

    final jobCard = JobCard(
      id: newJobCardDoc.id,
      cardNo: cardNo,
      createdAt: createdAt,
      sirveces: sirveces,
      done: done,
      phone: phone,
      name: name,
      carNo: carNo,
      km: km,
      model: model,
      nClyn: nClyn,
      chassiNo: chassiNo,
      signature: signature
    );

    final json = jobCard.toJson();

    await newJobCardDoc.set(json);
  }

  // Get all
  Stream<List<JobCard>> getAllJobCards() => FirebaseFirestore.instance
      .collection('JobCard')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => JobCard.fromJson(doc.data())).toList());

  // Get by car number
  Stream<List<JobCard>> getAllJobCardsByCarNo(String carNo) => FirebaseFirestore.instance
      .collection('JobCard')
      .where('carNo', isEqualTo: carNo)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => JobCard.fromJson(doc.data())).toList());
  
  // Update
  Future updateJobCard(
      String id,
      String cardNo,
      DateTime createdAt,
      String sirveces,
      bool done,
      String phone,
      String name,
      String carNo,
      String km,
      String model,
      String nClyn,
      String chassiNo,
      String signature) async {
    final newJobCardDoc =
        FirebaseFirestore.instance.collection('JobCard').doc();

    final jobCard = JobCard(
      id: newJobCardDoc.id,
      cardNo: cardNo,
      createdAt: createdAt,
      sirveces: sirveces,
      done: done,
      phone: phone,
      name: name,
      carNo: carNo,
      km: km,
      model: model,
      nClyn: nClyn,
      chassiNo: chassiNo,
      signature: signature
    );

    final json = jobCard.toJson();

    await newJobCardDoc.update(json);
  }

  // Delete
  Future deleteJobCard(String id) async {
    final jobCardDoc = FirebaseFirestore.instance.collection('JobCard').doc(id);
    
    await jobCardDoc.delete();
  }
}
