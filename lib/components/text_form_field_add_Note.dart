import 'package:flutter/material.dart';

class TextFormFieldAddNote extends StatelessWidget {
  final  hintText;
  final laboltext;
  final  controller;
  final  fun;
  final  style;
  final  onchage;
  final padding;
  const TextFormFieldAddNote(
      {super.key,
       this.hintText,
        this.laboltext,
      this.style,
       this.controller,
       this.fun,
        this.onchage,
        this.padding
      });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.top,
      maxLines: null,
      scrollPadding: EdgeInsets.symmetric(),
      cursorColor: const Color(0xff62FCD7),
      onChanged: onchage,
      style: style,
      validator: fun,
      controller: controller,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
         contentPadding: padding,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xff62FCD7)))),
    );
  }
}
