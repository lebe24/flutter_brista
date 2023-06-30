import 'package:flutter/material.dart';
import 'package:flutter_brista/model/coffee_item.dart';

class CoffeeWidget extends StatefulWidget {
   CoffeeWidget({super.key, required this.index, required this.callback});
  late int index;
  final Function(bool) callback;


  @override
  State<CoffeeWidget> createState() => _CoffeeWidgetState();
}

class _CoffeeWidgetState extends State<CoffeeWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0),
      end: const Offset(0, 2.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }
  void _toggleExpansion() {
  setState(() {
    _isExpanded = !_isExpanded;
    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  });
  widget.callback(_isExpanded);
}

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


 
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: GestureDetector(
        onTap: _toggleExpansion,
        child: SizedBox(
          height: 200,
          child: Hero(
            tag: Items[widget.index].name,
            child: Image.asset(Items[widget.index].image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}