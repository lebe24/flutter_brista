import 'package:flutter/material.dart';
import 'package:flutter_brista/model/coffee_item.dart';
import 'package:google_fonts/google_fonts.dart';


class CheckOut extends StatefulWidget {
  const CheckOut({super.key, required this.index, required this.selected, });
  final int index;
  final int selected;

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFBE3DEDE),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Hero(tag: Items[widget.index].name, child: Image.asset(Items[widget.index].image)),
                Text(Items[widget.index].name,
                style: GoogleFonts.lato(
                  color:Colors.brown,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                )),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ElevatedButton(
                    onPressed: (){}, child: Text('checkout')),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}