import 'package:flutter/material.dart';
import 'package:keep_notes/Services/db.dart';
import 'package:keep_notes/SideMenuBar.dart';
import 'NoteView.dart';
import 'CreateNoteView.dart';
import 'SearchPage.dart';
import 'package:keep_notes/Services/db.dart';
import 'package:keep_notes/main.dart';

import 'model/MyNotesModel.dart';




Color textColor= Colors.black;
Color themeColor= Colors.white;
String themeMode = 'Night';

bool bgWhite = true;
Color colorcard = Colors.grey.shade300;


class home extends StatefulWidget {
  const home({Key? key}): super(key:key);
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool isLoading = true;
  late List<Note> notesList;
  bool isLoadingpin = true;
  late List<Note> notesListpin;
GlobalKey<ScaffoldState> _drawerkey = GlobalKey();


Future createEntry(Note note) async{
  await NotesDatabase.instance.InsertEntry(note);
}
Future getAllpinNotes() async{
  this.notesListpin= await NotesDatabase.instance.readAllpinNotes();
  setState(() {
    isLoadingpin = false;
  });
}
  Future getAllpinNotNotes() async{
    this.notesList= await NotesDatabase.instance.readAllnopinNotes();
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllpinNotes();
    getAllpinNotNotes();

  }
Future getOneNote(int id) async{
  await NotesDatabase.instance.readOneNote(id);
}
Future updateOneNote(Note note) async{
  await NotesDatabase.instance.updateNote(note);
}
Future deleteOneNote(Note note) async{
  await NotesDatabase.instance.deleteNote(note);
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
      endDrawerEnableOpenDragGesture: true,
      key: _drawerkey,
      drawer: SideMenu(),
      backgroundColor: themeColor,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 12,bottom: 20),
        child: FloatingActionButton(

          backgroundColor: colorcard.withOpacity(0.95),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CreateNoteView()));
          },
          child: Icon(Icons.add,color: textColor,size: 38,),

        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 11,top: 7),
                        
                        height: 55,
                        decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(25),
                          color: colorcard,
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                IconButton(onPressed: (){
                                  _drawerkey.currentState!.openDrawer();
                                },
                                    icon: Icon(Icons.menu,color: textColor.withOpacity(0.7),)),
                                SizedBox(width: 13,),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchView()));
                                  },
                                  child: Container(
                                    height: 55,width: 220,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text("Search Your Notes",style:TextStyle(color: textColor.withOpacity(0.7),fontSize: 16),),
                                      ],
                                    ),
                                  ),
                                )
                      
                              ],
                            ),
                      
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 7,),
                    Container(
                      height: 55,
                      margin: EdgeInsets.only(top: 7,right: 11),
                      child: TextButton(

                        onPressed: (){
                          if(bgWhite == true){
                            textColor = Colors.white;
                            themeColor = Colors.grey.shade900;
                            colorcard = Colors.black45;
                            themeMode = "Day";
                            bgWhite = false;
                          }
                          else{
                            textColor = Colors.black;
                            themeColor = Colors.white;
                            themeMode = "Night";
                            colorcard = Colors.grey.shade300;
          
                            bgWhite = true;
                          }
                          setState(() {
          
                          });
                        },
                        child: Container(
                          height: 55,
          
          
          
                          child: Row(
                            children: [
                              Text(themeMode,style: TextStyle(color: textColor.withOpacity(0.7)),),
                              SizedBox(width: 7,),
                              Icon(Icons.remove_red_eye_outlined,color: textColor.withOpacity(0.7),)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 11,),

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
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context)=>NoteView(note: notesListpin[index],)));

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
                             Navigator.pushReplacement(context,
                                 MaterialPageRoute(builder: (context)=>NoteView(note: notesList[index],)));

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