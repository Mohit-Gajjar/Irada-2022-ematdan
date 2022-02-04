import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future<void> addBooth(data, String id) async {
    return await FirebaseFirestore.instance
        .collection("booths")
        .doc(id)
        .set(data);
  }

  Future<void> addVotedUser(data, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(data);
  }

  Future<bool?> isVoted(String userId) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("users");

    DocumentSnapshot snapshot = await reference.doc(userId).get();
    var data = snapshot.data() as Map;
    return data['voted'];
  }

  Future<String?> winnerName(String id) async {
    print(id);
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Candidates')
        .where("id", isEqualTo: id)
        .get();
    var a = snapshot.docs.isNotEmpty ? snapshot.docs[0]["candidateName"] : "";
    print(a);
    return a;
  }

  Future<void> addCandidate(
      data, String boothId, String candidateId, String partyName) async {
    addCan(candidateId, data);
    return await FirebaseFirestore.instance
        .collection("booths")
        .doc(boothId)
        .collection("Parties")
        .doc(partyName)
        .collection("Candidates")
        .doc(candidateId)
        .set(data);
  }

  addCan(String id, data) async {
    return await FirebaseFirestore.instance.collection("Candidates").add(data);
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
