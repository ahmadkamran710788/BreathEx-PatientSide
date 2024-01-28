import 'package:fyp_patent/Features/Search/Services/search_services.dart';
import 'package:fyp_patent/Features/Search/Widget/search_doctor.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../Provider/patient_provider.dart';
import '../../../common/loader.dart';
import '../../../models/doctor.dart';


class SearchScreen extends StatefulWidget {
  static const String routeName='search-screen';
  final String SearchQuery;
  const SearchScreen({Key? key,required this.SearchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Doctor>? doctors;
  final SearchServices searchServices=SearchServices();
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;


  @override
  void initState() {

    super.initState();
    fetchSearchedDoctor();
  }

  fetchSearchedDoctor()async{
   doctors= await searchServices.fetchSearchedDoctor(context: context, SearchQuery: widget.SearchQuery);
  setState(() {

  });
  }
  void NavigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments:query );
  }



  @override
  Widget build(BuildContext context) {

    final patient=Provider.of<PatientProvider>(context).patient;
    final patient_name=patient.name;
    return doctors==null? const Loader() :Scaffold(
     appBar:AppBar(
       backgroundColor: Colors.white,
       title: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text("Hi, $patient_name",style: TextStyle(color: Colors.black),),
           Text(
             "How are you feeling today?",
             style: Theme.of(context).textTheme.bodySmall,
           ),
         ],
       ),
       actions: [
         IconButton(
           onPressed: () {},
           icon: const Icon(Ionicons.notifications_outline,color: Colors.black,),
         ),
         IconButton(
           onPressed: () {
             setState(() {
               _isSearching = !_isSearching;
             });
           },
           icon: _isSearching
               ? Icon(
             Ionicons.close_outline,
             color: Colors.black,
           )
               : Icon(
             Ionicons.search_outline,
             color: Colors.black,
           ),
         ),
       ],
       bottom: _isSearching
           ? PreferredSize(
         preferredSize: Size.fromHeight(60),
         child: Padding(
             padding: const EdgeInsets.all(8.0),
             child:TextFormField(
               onFieldSubmitted: NavigateToSearchScreen,
               decoration: InputDecoration(
                   prefixIcon: InkWell(
                     onTap: (){},
                     child: const Padding(padding: EdgeInsets.only(
                       left: 6,
                     ),
                       child:const  Icon(Icons.search,color: Colors.black,size: 23,),
                     ),
                   ),
                   filled: true,
                   fillColor: Colors.white,
                   contentPadding: EdgeInsets.only(top: 10),
                   border: const OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(7),),
                       borderSide: BorderSide.none
                   ),
                   enabledBorder: const  OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(7)),
                       borderSide: BorderSide(color: Colors.black38,width: 1)
                   ),
                   hintText: 'Search ',
                   hintStyle: const TextStyle(
                       fontWeight: FontWeight.w500,fontSize: 17
                   )

               ),
             )
         ),
       )
           : null,
     ),


      body:doctors==null? const Loader():
      Column(
        children: [
          Expanded(child: ListView.builder(itemCount:doctors!.length,itemBuilder: (context,index){
            return SearchDoctor(doctor: doctors![index]);

          }))
        ],
      ),
    );
  }
}
