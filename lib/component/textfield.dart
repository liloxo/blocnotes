import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final String hintxt;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const Textfield({Key? key, required this.hintxt, required this.controller, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
     controller: controller,
       decoration: InputDecoration(
         hintText: hintxt,
         prefixIcon: const Icon(Icons.note,color: Colors.blueGrey,),
         enabledBorder: OutlineInputBorder(
           borderSide: const BorderSide(
             width: 1,
             color: Colors.blueGrey
           ),
           borderRadius: BorderRadius.circular(13)
         ),
         focusedBorder: OutlineInputBorder(
           borderSide: const BorderSide(
             color: Colors.blueGrey
           ),
           borderRadius: BorderRadius.circular(13)
         ),
       ),
      );
  }
}