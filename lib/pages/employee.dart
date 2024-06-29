import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/service/database.dart';
import 'package:random_string/random_string.dart';


class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => EmployeeState();
}

class EmployeeState extends State<Employee> {
  TextEditingController namecontroller=new TextEditingController();
  TextEditingController agecontroller=new TextEditingController();
  TextEditingController locationcontroller=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar
      (title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Employee",style:TextStyle(color:Colors.blue,fontSize:20.0,fontWeight:FontWeight.bold 
        )),
        Text("form",style:TextStyle(color:Colors.yellow,fontSize:20.0,fontWeight:FontWeight.bold,
        ))
      ],),),





      body:Container(
        margin:EdgeInsets.only(left: 20.0,top:30.0, right:20.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
          Text("Name",style:TextStyle(color:Colors.black,fontSize:24,fontWeight: FontWeight.bold) ,),
          SizedBox(height: 10.0,),
          Container(
            padding:EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border:Border.all()
            ),
            child:TextField(
              controller: namecontroller
              ,
              decoration: InputDecoration(border:InputBorder.none),
            )
          ),

SizedBox(height:20),
  Text("Age",style:TextStyle(color:Colors.black,fontSize:24,fontWeight: FontWeight.bold) ,),
          SizedBox(height: 10.0,),
          Container(
            padding:EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border:Border.all()
            ),
            child:TextField(
              controller: agecontroller,
              decoration: InputDecoration(border:InputBorder.none),
            )
          ),



SizedBox(height:20),
  Text("Location",style:TextStyle(color:Colors.black,fontSize:24,fontWeight: FontWeight.bold) ,),
          SizedBox(height: 10.0,),
          Container(
            padding:EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border:Border.all()
            ),
            child:TextField(
              controller: locationcontroller,
              decoration: InputDecoration(border:InputBorder.none),
            )
          ),
  SizedBox(height: 30.0,),

        Center(
          child: ElevatedButton(onPressed:()async{
            String Id=randomAlphaNumeric(10);
          Map<String, dynamic> employeeInfoMap={
            "Name":namecontroller.text,
            "Age":agecontroller.text,
            "Id":Id,
            "Location":locationcontroller.text,
          };
          await DatabaseMethods().addEmployeeDetails(employeeInfoMap, Id).then((value) {
         print("success");
          });

          }, child: Text("add",style:TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))
          
          
          ),
        ),]))
    );
  }
}