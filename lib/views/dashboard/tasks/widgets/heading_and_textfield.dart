import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../../../helpers/custom_text.dart';
import '../../../../helpers/reusable_textfield.dart';

class HeadingAndTextfield extends StatelessWidget {
  final String title;
  final bool showEditTitle;
  final VoidCallback? editTitle;
  final double? fontSize;
  final String? hintText;
  final bool? readOnly;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool showDeleteIcon;
  final VoidCallback? onDelete;
  final bool showEditIcon;
  final VoidCallback? onEdit;
  final bool showEyeIcon;
  final VoidCallback? onEyeTap;
  final bool showAddIcon;
  final VoidCallback? onAddTap;

  const HeadingAndTextfield({
    super.key,
    required this.title,
    this.hintText,
    this.onTap,
    this.readOnly,
    this.validator,
    this.controller,
    this.onChanged,
    this.maxLines,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.fontSize,
    this.showDeleteIcon = false,
    this.onDelete,
    this.showEditIcon = false,
    this.onEdit, 
    this.showEyeIcon = false,
    this.editTitle, 
    this.showEditTitle = false,
    this.onEyeTap,
    this.showAddIcon = false,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            InkWell(
              onTap: editTitle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Visibility(
                visible: showEditTitle,
                child: const Icon(Icons.edit,color: Colors.grey,size: 18,)),
                  const SizedBox(width: 1),
                  SizedBox(
                 
                width: 270,
                    child: CustomTextWidget(
                    text: title,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                    fontSize: fontSize ?? 12,
                                  ),
                  ),
                ],
              ),
            ),
           
             Visibility(
                visible: showAddIcon,
                child: InkWell(
                  onTap: onAddTap,
                  child: const Icon(
                    CupertinoIcons.add_circled_solid,
                    color: Color.fromARGB(255, 110, 110, 110),
                  ),
                ),
              ),  
              if(showEyeIcon == true)
              Visibility(
                visible: showEyeIcon,
                child: InkWell(
                  onTap: onEyeTap,
                  child: const Icon(
                    CupertinoIcons.eye_solid,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
          ReUsableTextField(
            showDeleteIcon: showDeleteIcon,
            onDelete: showDeleteIcon ? onDelete : null,
            showEditIcon: showEditIcon,
            onEdit: showDeleteIcon ? onEdit : null,
            controller: controller,
            onChanged: onChanged,
            onTap: onTap,
            readOnly: readOnly,
            hintText: hintText ?? title,
            maxLines: maxLines ?? 1,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            keyboardType: keyboardType,
            validator: validator,
          )
        ],
      ),
    );
  }
}

class HeadingAndTextfieldInRow extends StatelessWidget {
  final String title;
  final String hintText;
  final bool? readOnly;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const HeadingAndTextfieldInRow(
      {super.key,
      required this.title,
      required this.hintText,
      this.readOnly,
      this.validator,
      this.controller,
      this.maxLines,
      this.suffixIcon,
      this.prefixIcon,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Row(
        children: [
          CustomTextWidget(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
            maxLines: 2,
          ),
          const SizedBox(width: 10.0),
          Flexible(
            child: ReUsableTextField(
              controller: controller,
              readOnly: readOnly,
              hintText: hintText,
              maxLines: maxLines,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              keyboardType: keyboardType,
              validator: validator,
            ),
          )
        ],
      ),
    );
  }
}
