import 'package:flutter/material.dart';
import 'package:keep_notes/Services/db.dart';
import 'package:keep_notes/main.dart';
import 'package:keep_notes/home.dart';
import 'package:keep_notes/model/MyNotesModel.dart';
class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key});

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  TextEditingController title = new TextEditingController();
  TextEditingController content = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));
        return true;
      },
      child: Scaffold(
        backgroundColor: themeColor,
        appBar: AppBar(
          title: Container(
              margin: EdgeInsets.only(top: 10),
              child: Text("Create Note",style: TextStyle(color: textColor,fontSize: 28),)),
          iconTheme: IconThemeData(color: textColor),
          backgroundColor: themeColor,
          elevation: 0.0,
          actions: [
            IconButton(
                splashRadius: 17,
                onPressed: ()async{
                  await NotesDatabase.instance.InsertEntry(Note(pin: false,isArchived: false, title: title.text, content: content.text, createdTime: DateTime.now()));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> home()));
                  },
                icon: Icon(Icons.save_outlined,size: 25,)),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(

                  autocorrect: false,
                  enableSuggestions: false,
                  controller: title,
                  cursorColor: textColor.withOpacity(0.5),
                  cursorHeight: 31,
                  style: TextStyle(fontSize: 24,color: textColor,fontWeight: FontWeight.w400,),
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Title",
                      hintStyle: TextStyle(fontSize: 24,color: textColor.withOpacity(0.3),fontWeight: FontWeight.w400,)
                  ),
                ),
                Container(
                  height: 400,
                  child: TextField(

                    autocorrect: false,
                    enableSuggestions: false,
                    controller: content,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 50,
                    cursorColor: textColor.withOpacity(0.5),
                    cursorHeight: 25,
                    style: TextStyle(color: textColor,fontSize: 18,fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Description",
                        hintStyle: TextStyle(color: textColor.withOpacity(0.3),fontSize: 18,fontWeight: FontWeight.w400)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
