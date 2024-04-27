import 'package:flutter/material.dart';
import 'package:keep_notes/SideMenuBar.dart';
import 'NoteView.dart';
import 'CreateNoteView.dart';
import 'home.dart';
import 'Services/db.dart';
import 'package:keep_notes/main.dart';

import 'model/MyNotesModel.dart';








class ArchiveView extends StatefulWidget {
  const ArchiveView({Key? key}): super(key:key);
  @override
  State<ArchiveView> createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {
  bool isLoading = true;
  late List<Note> notesList;
  bool isLoadingpin = true;
  late List<Note> notesListpin;
  @override



  Future getAllArchivepinNotes() async{
    this.notesListpin= await NotesDatabase.instance.readAllarchivepinNotes();
    setState(() {
      isLoadingpin = false;
    });
  }
  Future getAllArchivenopinNotes() async{
    this.notesList= await NotesDatabase.instance.readAllarchiveNotpinNotes();
    setState(() {
      isLoading= false;
    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllArchivepinNotes();
    getAllArchivenopinNotes();
  }

  @override
  Widget build(BuildContext context) {

    return isLoading?
    Scaffold(
      backgroundColor: themeColor,
      body:Center(
        child: CircularProgressIndicator(color: textColor,),
      )
      ,):
    Scaffold(
      appBar: AppBar(

        iconTheme: IconThemeData(color: textColor),
        backgroundColor: themeColor,
        elevation: 0.0,
        title: Text("Archived",style: TextStyle(color: textColor,fontSize: 24),),


      ),


      backgroundColor: themeColor,
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [


                Container(

                  margin: EdgeInsets.only(left: 11,right: 11),
                  child: ListView.builder(
                    shrinkWrap:true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(top: 6,bottom: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(color: textColor.withOpacity(0.2),width: 1)
                        ),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>NoteView(note: notesListpin[index])));

                          },
                          child: ListTile(
                            title: Text(notesListpin[index].title,style: TextStyle(color: textColor,fontSize: 20,fontWeight: FontWeight.w500),),
                            subtitle: Text(notesListpin[index].content.length > 70? "${notesListpin[index].content.substring(0,50)}....":notesListpin[index].content,style: TextStyle(color: textColor,fontSize: 17,),),
                          trailing: Icon(Icons.push_pin,color: textColor,size: 20,),
                          ),
                        ),
                      );

                    },itemCount: notesListpin.length,
                  ),
                ),
                Container(

                  margin: EdgeInsets.only(left: 11,right: 11),
                  child: ListView.builder(
                    shrinkWrap:true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(top: 6,bottom: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(color: textColor.withOpacity(0.2),width: 1)
                        ),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>NoteView(note: notesList[index])));

                          },
                          child: ListTile(
                            title: Text(notesList[index].title,style: TextStyle(color: textColor,fontSize: 20,fontWeight: FontWeight.w500),),
                            subtitle: Text(notesList[index].content.length > 70? "${notesList[index].content.substring(0,50)}....":notesList[index].content,style: TextStyle(color: textColor,fontSize: 17,),),

                          ),
                        ),
                      );

                    },itemCount: notesList.length,
                  ),
                ),
                Container(height: 100,)
              ],
            ),

          ),
        ),
      ),

    );
  }
}