import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const whiteColor = Colors.white;
const greyColor = Colors.white;
// const whiteColor = Colors.white;
// const whiteColor = Colors.white;

//TextStyles
TextStyle headingText(textColor) {
  return TextStyle(
    color: textColor,
    fontSize: 22.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );
}

TextStyle descriptionText(textColor) {
  return TextStyle(
    color: textColor,
    fontSize: 14.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );
}

//TextFormFields
InputDecoration appInputDecoration(label) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    fillColor: whiteColor,
    contentPadding: EdgeInsets.all(11),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black26),
    ),
    border: OutlineInputBorder(),
    labelText: label,
  );
}

// //Background Image
// SvgPicture bgImage(context) {
//   return SvgPicture.asset(
//     'assets/image/bgimage.svg',
//     alignment: Alignment.center,
//     width: MediaQuery.of(context).size.width,
//     height: MediaQuery.of(context).size.height,
//     fit: BoxFit.cover,
//   );
// }

//Button STyle
ButtonStyle appButton() {
  return ElevatedButton.styleFrom(
    elevation: 1,
    padding: EdgeInsets.zero,
    backgroundColor: Colors.amber,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(11),
    ),
  );
}

//Button er Text Style
TextStyle buttonTextStyle() {
  return TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );
}

//Button er height-width
Ink buttonColor(String buttonText) {
  return Ink(
    decoration: BoxDecoration(
      color: greyColor,
      borderRadius: BorderRadius.circular(11),
    ),
    child: Container(
      height: 44.h,
      alignment: Alignment.center,
      child: Text(buttonText, style: buttonTextStyle()),
    ),
  );
}
