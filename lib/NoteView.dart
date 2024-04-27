import 'package:flutter/material.dart';
import 'package:keep_notes/EditNoteView.dart';
import 'package:keep_notes/Services/db.dart';
import 'package:keep_notes/model/MyNotesModel.dart';
import 'main.dart';
import 'package:keep_notes/home.dart';
import 'package:keep_notes/model/MyNotesModel.dart';
class NoteView extends StatefulWidget {
Note note;
NoteView({required this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
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
          backgroundColor: themeColor,
          elevation: 0.0,
          iconTheme: IconThemeData(color: textColor),
          actions: [
            IconButton(
              splashRadius: 17,
              onPressed: ()async{
                await NotesDatabase.instance.pinNote(widget.note);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));

              },
                icon: Icon(widget.note.pin ? Icons.push_pin:Icons.push_pin_outlined,size: 25,),
            ),
            IconButton(
                splashRadius: 17,
                onPressed: ()async{
                  await NotesDatabase.instance.archNote(widget.note);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));

                },
                icon: Icon(widget.note.isArchived ? Icons.archive:Icons.archive_outlined,size: 25,)),
            IconButton(
                splashRadius: 17,
                onPressed: ()async{
                  await NotesDatabase.instance.deleteNote(widget.note);

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));
                },
                icon: Icon(Icons.delete,size: 25,)),
            IconButton(
                splashRadius: 17,
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditNoteView(note: widget.note,)));
                },
                icon: Icon(Icons.edit_outlined,size: 25,)),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.note.title,style: TextStyle(color: textColor,fontWeight: FontWeight.w400,fontSize: 24),),
                SizedBox(height: 10,),
                Text(widget.note.content,style: TextStyle(color: textColor,fontSize: 18,fontWeight: FontWeight.w300),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
