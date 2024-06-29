
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addEmployeeDetails(Map<String, dynamic> employeeInfoMap, String id) async {
    // Correct placement of the parentheses
    return await FirebaseFirestore.instance
        .collection("Employee")  // Close the collection method here
        .doc(id)  // Then call the doc method
        .set(employeeInfoMap);  // Set the employee information map
  }
  Future<Stream<QuerySnapshot>>getEmployeeDetails()async{
    return await FirebaseFirestore.instance.collection("Employee").snapshots();   
  }
  Future updateEmployeeDetail(String id,Map<String,dynamic>updateInfo)async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).update(updateInfo);   
  }
  Future delteEmployeeDetail(String id)async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).delete();   
  }
}

