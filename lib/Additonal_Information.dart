import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Additional extends StatelessWidget {
 final IconData icon;
 final String label;
 final String value;
  const Additional({super.key,
  required this.icon,
  required this.label,
  required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Icon(icon,color: Colors.blue,),
          const SizedBox (
            height: 7,
          ),
          Text(label,style:const  TextStyle(fontWeight:FontWeight.w300),),
          Text(value,style: const TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
        ],
        
            );
  }
}