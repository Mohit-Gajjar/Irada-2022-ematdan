import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future<void> addBooth(data, String id) async {
    return await FirebaseFirestore.instance
        .collection("booths")
        .doc(id)
        .set(data);
  }

  Future<void> addCandidate(
      data, String boothId, String candidateId, String partyName) async {
    return await FirebaseFirestore.instance
        .collection("booths")
        .doc(boothId)
        .collection("Parties")
        .doc(partyName)
        .collection("Candidates")
        .doc(candidateId)
        .set(data);
  }

  Future<void> addParty(String name, String boothId, data) async {
    return await FirebaseFirestore.instance
        .collection("booths")
        .doc(boothId)
        .collection("Parties")
        .doc(name)
        .set(data);
  }

  getBooth() async {
    return FirebaseFirestore.instance.collection("booths").snapshots();
  }

  getBoothById(String id) async {
    return FirebaseFirestore.instance
        .collection("booths")
        .where("boothId", isEqualTo: id)
        .get();
  }

  getParties(String boothId) async {
    return FirebaseFirestore.instance
        .collection("booths")
        .doc(boothId)
        .collection("Parties")
        .snapshots();
  }

  getCandidates(String boothId, String partyName) async {
    return FirebaseFirestore.instance
        .collection("booths")
        .doc(boothId)
        .collection('Parties')
        .doc(partyName)
        .collection('Candidates')
        .snapshots();
  }

  deleteBooth(String id) async {
    return FirebaseFirestore.instance.collection("booths").doc(id).delete();
  }
}
