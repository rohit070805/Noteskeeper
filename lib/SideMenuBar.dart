import 'package:flutter/material.dart';
import 'package:keep_notes/ArchiveView.dart';
import 'package:keep_notes/home.dart';
import 'package:keep_notes/main.dart';
class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: themeColor
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 25,vertical: 16),
                  child: Text("Keep Notes",style: TextStyle(color: textColor,fontSize: 25,fontWeight: FontWeight.w500),)),
              Divider(
                color: textColor.withOpacity(0.2),
              ),
              Container(
                padding: EdgeInsets.only(left: 5,right: 5,top: 5),
                margin: EdgeInsets.only(right: 20),
                child: TextButton(
                    onPressed: (){
                      Navigator.pop(context);

                }, child: Row(
                  children: [
                    Icon(Icons.notes,color: textColor,size: 27),
                    SizedBox(width: 10,),
                    Text("Notes",style:TextStyle(color: textColor,fontSize: 18))
                  ],
                )
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                margin: EdgeInsets.only(right: 20),
                child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveView()));

                    }, child: Row(
                  children: [
                    Icon(Icons.archive_outlined,color: textColor,size: 27),
                    SizedBox(width: 10,),
                    Text("Archived",style:TextStyle(color: textColor,fontSize: 18))
                  ],
                )
                ),
              ),
            ],
          ),
        ),
      ),
     
    );
  }
}
