import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:provider/provider.dart';
import 'package:todolist/Provider/CatergoryProvider.dart';
import 'package:todolist/Provider/pagerItemProvider.dart';

class ChoiceChipItems extends StatefulWidget {
 
  @override
  _ChoiceChipItemsState createState() => _ChoiceChipItemsState();
}

class _ChoiceChipItemsState extends State<ChoiceChipItems> {
  var _value=0;
  @override
  Widget build(BuildContext context) {

    final _height = MediaQuery.of(context).size.height;
     final categoryItem=Provider.of<CategoryProvider>(context).items;
     final pageViewerItem=Provider.of<PagerItemProvider>(context,listen: false);
     final _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: _height*0.1,
      width:_width,
      child: ListView.builder(
                   padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryItem.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ChoiceChip(
                        label: Text(categoryItem[index],style: TextStyle(color:Colors.black,fontSize: 15),),
                        selected: _value==index,
                        selectedColor: Colors.blue[200],
                        disabledColor: Colors.white,

                        onSelected: (selected){
                          setState(() {
                             _value=index;
                              pageViewerItem.changeValue(index);
                          });
                        },
                      )

                        

                      
                    );
                  },
      ),
    );
  }
}