import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {

  final TextEditingController editingController;
  final IconData? iconData;
  final String? assetRef;
  final String? lableText;
  final bool? isObscure;

  CustomTextFieldWidget({
    super.key,
    required this.editingController,
    this.iconData,
    this.assetRef,
    this.isObscure,
    this.lableText,

  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      decoration: InputDecoration(
        labelText: lableText,
        prefixIcon: iconData != null
            ? Icon(iconData)
            : Padding(
            padding: EdgeInsets.all(8),
            child: Image.asset(assetRef.toString()),
                      ),
          labelStyle: const TextStyle(
            fontSize: 18,
      ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Colors.grey,
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Colors.grey,
            )
        ),
      ),
      obscureText: isObscure!,
    );
  }
}
