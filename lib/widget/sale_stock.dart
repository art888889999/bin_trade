
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SaleStock extends StatefulWidget {
  const SaleStock({
    super.key,
  });


  @override
  State<SaleStock> createState() => _SaleStockState();
}

class _SaleStockState extends State<SaleStock> {
  int maxWidth = 300;
  int width = 200;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      final random = Random().nextInt(maxWidth);
      width = random;
      setState(() {
        
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    maxWidth = MediaQuery.of(context).size.width.round() - 80;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${100 -((width * 100)/maxWidth).round()}%', style: const TextStyle(color: Colors.red, fontSize: 12),),
        AnimatedContainer(
          duration: const Duration(seconds: 1),
            height: 5,
            width: maxWidth.toDouble() - width.toDouble(),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 4),
        Expanded(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4)))),
                    const SizedBox(width: 3),
                    Text('${((width * 100)/maxWidth).round()}%', style: const TextStyle(color: Colors.green, fontSize: 12),),
                    
      ],
    );
  }
}
