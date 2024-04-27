

import 'package:flutter/material.dart';
import 'package:keep_notes/Services/db.dart';
import 'package:keep_notes/main.dart';
import 'package:keep_notes/home.dart';
import 'package:keep_notes/NoteView.dart';

import 'model/MyNotesModel.dart';
class EditNoteView extends StatefulWidget {

  Note note;
  EditNoteView({required this.note});

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late String NewTitle ;
  late String NewNoteDet;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.NewTitle = widget.note.title.toString();
    this.NewNoteDet = widget.note.content.toString();
  }
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
              child: Text("Edit Note",style: TextStyle(color: textColor,fontSize: 28),)),

          iconTheme: IconThemeData(color: textColor),
          backgroundColor: themeColor,
          elevation: 0.0,
          actions: [
            IconButton(
                splashRadius: 17,
                onPressed: () async{
                  Note newNote = Note(content: NewNoteDet,title: NewTitle,createdTime: DateTime.now(),isArchived: widget.note.isArchived,pin: widget.note.pin,id: widget.note.id);
                  await NotesDatabase.instance.updateNote(newNote);


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
                Form(
                  child: TextFormField(
                    autocorrect: false,
                    enableSuggestions: false,
                    initialValue: NewTitle,
                    cursorColor: textColor.withOpacity(0.5),
                    cursorHeight: 31,

                    onChanged: (value){
                      NewTitle = value;
                    },
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
                ),
                Container(
                  height: 400,
                  child: Form(
                    child: TextFormField(

                      autocorrect: false,
                      enableSuggestions: false,
                      initialValue: NewNoteDet,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 50,
                      cursorColor: textColor.withOpacity(0.5),
                      cursorHeight: 25,
                      onChanged: (value){
                        NewNoteDet = value;
                      },
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
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
