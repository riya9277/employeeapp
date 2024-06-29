import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/employee.dart';
import 'package:flutter_application_1/service/database.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namecontroller=new TextEditingController();
  TextEditingController agecontroller=new TextEditingController();
  TextEditingController locationcontroller=new TextEditingController();
Stream? EmployeeStream;

getontheload()async{
  EmployeeStream=await DatabaseMethods().getEmployeeDetails();
  setState(() {
    
  });
}

@override
  void initState() {
    getontheload();
    // TODO: implement initState
    super.initState();
  }
Widget allEmployeeDetails()
{
  return StreamBuilder(
    stream: EmployeeStream,
    
    builder:(context,AsyncSnapshot snapshot){
    return snapshot.hasData
    ?ListView.builder(
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context,index){
        DocumentSnapshot ds=snapshot.data.docs[index];
        return  Container(
          margin:EdgeInsets.only(bottom: 20.0),
          child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width:MediaQuery.of(context).size.width,
                  decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Row(
                      
                      children: [
                        Text("Name:"+ds["Name"],style: TextStyle(color:Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold), 
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            namecontroller.text=ds["Name"];
                            agecontroller.text=ds["Age"];
                            locationcontroller.text=ds["Location"];
                            editemployeedetail(ds["Id"]);
                          },
                          child: Icon(Icons.edit,color: Colors.orange,)),
                          SizedBox(width: 5.0,),
                          GestureDetector(
                            onTap: ()async{
                              await DatabaseMethods().delteEmployeeDetail(ds["Id"]);

                            },
                            child: Icon(Icons.delete,color: Colors.orange,))
                      ],
                    ),
                   Text("Age:"+ds["Age"],style: TextStyle(color:Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold), )
                  ,
                   Text("Location:"+ds["Location"],style: TextStyle(color:Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold), )
                  ],),
                ),
              ),
        );
      })
    :Container();
    
  } );

}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder:(context)=>Employee()));
      },child:Icon(Icons.add)),
      appBar: AppBar
      (title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("flutter",style:TextStyle(color:Colors.blue,fontSize:20.0,fontWeight:FontWeight.bold 
        )),
        Text("firebase",style:TextStyle(color:Colors.yellow,fontSize:20.0,fontWeight:FontWeight.bold 
        ))
      ],),),
       body:Container(
        margin:EdgeInsets.only(left:20.0,right: 20.0,top:30),
        child:Column(
          children: [
           
      Expanded(child: allEmployeeDetails()),


        ],)
       )
    );
  }
  Future editemployeedetail(String id)=>showDialog(context: context, builder:(context)=> AlertDialog(
    content:Container(
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                    Navigator.pop(context);
                },
                child: Icon(Icons.cancel
                ),
                ),
                SizedBox(width: 60.0,),
                Text("Edit",style:TextStyle(color:Colors.blue,fontSize:20.0,fontWeight:FontWeight.bold 
        )),
        Text("Details",style:TextStyle(color:Colors.yellow,fontSize:20.0,fontWeight:FontWeight.bold 
        ))
                ],
               
                ),
                SizedBox(height: 20,),
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
          SizedBox(height: 30.0),
         Center(
           child: ElevatedButton(onPressed: ()async{
            Map<String,dynamic>updateInfo={
              "Name":namecontroller.text,
              "Age":agecontroller.text,
              "Id":id,
              "Location":locationcontroller.text,
            };
            await DatabaseMethods().updateEmployeeDetail(id, updateInfo).then((value){
              Navigator.pop(context);
            });
           }, child: Text("Update")
           ),
         ) 
                ]
                ,)
                ),
                )  ,
   ) ;
}