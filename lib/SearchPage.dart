import 'package:flutter/material.dart';
import 'package:keep_notes/Services/db.dart';
import 'NoteView.dart';
import 'home.dart';
import 'model/MyNotesModel.dart';
class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<int> SearchResultsId = [];
  List<Note> SearchResultNotes = [];
  bool isLoading = false;
  void SearchResult(String query) async{
    SearchResultNotes.clear();
    setState(() {
      isLoading = true;
    });
    final ResultIds = await NotesDatabase.instance.getNoteString(query);
    List<Note?> SearchResultNotesLocal = [];
    ResultIds.forEach((element) async{
      final SeachNote= await NotesDatabase.instance.readOneNote(element);
      SearchResultNotesLocal.add(SeachNote);
      setState(() {
        SearchResultNotes.add(SeachNote!);
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8,right: 8,top: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: colorcard),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon:Icon(Icons.arrow_back,color: textColor,) ),
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                                cursorColor: textColor,
                                style: TextStyle(fontSize: 18,color: textColor,fontWeight: FontWeight.w400,),
                                decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Search Your Notes",
                        hintStyle:TextStyle(color: textColor.withOpacity(0.7),fontSize: 18)
                      ),
                        onSubmitted: (value){
                          setState(() {
                            SearchResult(value.toLowerCase());
                          });
                        },

                      ),
                    )
                  ],
                ),

              ),
                Container(
          child: Column(
            children: [
              Container(

                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Search Results",style: TextStyle(color: textColor.withOpacity(0.5),fontSize: 16,fontWeight: FontWeight.bold),)
                  ],
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
                              MaterialPageRoute(builder: (context)=>NoteView(note: SearchResultNotes[index],)));

                        },
                        child: ListTile(
                          title: Text(SearchResultNotes[index].title,style: TextStyle(color: textColor,fontSize: 20,fontWeight: FontWeight.w500),),
                          subtitle: Text(SearchResultNotes[index].content.length > 70? "${SearchResultNotes[index].content.substring(0,50)}....":SearchResultNotes[index].content,style: TextStyle(color: textColor,fontSize: 17,),),

                        ),
                      ),
                    );

                  },itemCount:SearchResultNotes.length,
                ),
              ),

            ],
          ),
                )
            ],

          ),
        ),
      ),
    );
  }

}
