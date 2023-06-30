import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_brista/check_out.dart';
import 'package:flutter_brista/model/coffee_item.dart';
import 'package:flutter_brista/widget/Coffee_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> data = [];
  int _focusedIndex = -1, selected = 0;
  bool _isExpanded = true;

  
  void _onItemFocus(int index) {
    print(index);
    setState(() {
      _focusedIndex = index;
    });
  }

  void setExpand(bool expand){
    setState(() {
      _isExpanded = !expand;
    });
  }

  void onAdd() {
    setState(() {
      selected++;
    });
  }
  void onMinus() {
    setState(() {
      selected--;
    });
  }


  @override
  void initState() {
    super.initState();
    for (int i = 0; i < Items.length; i++) {
      data.add(Random().nextInt(100) + 1);
    }
  }

  Widget _buildItemDetail() {
    if (_focusedIndex<0) return const Text("Nothing selected");

    if (data.length > _focusedIndex) {return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: onMinus, icon: const Icon(Icons.remove)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("ITEM ${_focusedIndex + 1}:",
          style: GoogleFonts.lato(
            color:Colors.brown,
          fontSize: 25,
          fontWeight: FontWeight.bold
          ),
          ),
        ),
        Text("$selected",
        style: GoogleFonts.lato(
            color:Colors.brown,
          fontSize: 25,
          fontWeight: FontWeight.bold
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
        ),
        ],);
    }
    return const Text("No Data");
  }

  Widget _buildListItem(BuildContext context, int index) {   
  //horizontal
    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CoffeeWidget(
          index: index,
          callback:setExpand
        ),
        Text(Items[index].name,
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(
          color:Colors.brown,
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),)
        ],
      ),
    );
  }

  ///Override default dynamicItemSize calculation
  double customEquation(double distance){
    // return 1-min(distance.abs()/500, 0.2);
    return 1-(distance/1000);
  }


  @override
  Widget build(BuildContext context) {
    final translation = _isExpanded ? const Offset(150, 0) : const Offset(0, 0);
    final curve = _isExpanded ? Curves.easeOut : Curves.easeIn;

    return Scaffold(
      backgroundColor: Color(0xFBE3DEDE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFBE3DEDE),
        title: Center(child: SizedBox(height:50,child: Image.asset('assets/coffee/logo2.png'))),
      ),
      body: Stack(children: [
        ScrollSnapList(
          onItemFocus: _onItemFocus,
          itemSize: 150,
          itemBuilder: _buildListItem,
          itemCount: data.length,
          dynamicItemSize: true,
          // dynamicSizeEquation: customEquation, //optional
        ),
        Center(child: _buildItemDetail()),
        Positioned(
          bottom: 200,
                right:70,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            transform: Matrix4.translationValues(
              translation.dx, translation.dy, 0),
            child: IconButton(
              iconSize: 40,
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOut(index:_focusedIndex,selected:selected) ),
            ),
            icon: const Icon(Icons.arrow_forward))
          )
        )
      ]),
    );
  }
}