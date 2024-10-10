import 'package:dmb_app/utils/color_pallete_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFieldWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final int? maxLinesText;
  final String errorMsgText;
  final TextInputType? keyboardTextInputType;
  final Icon? preffixIcon;
  final IconButton? suffixIcon;
  final bool? isDropdownType;
  final dynamic dropdownSelected;
  final List<dynamic>? dropdownItems;
  final GlobalKey? dropdownGlobalKey;
  final FocusNode? focusNode;
  final bool? isEnabeledField;
  final bool? isRadOnlyField;
  final bool? isPasswordField;
  final bool? isStringDataTypeDropdown;
  final Function(dynamic)? dropdownOnChange;
  final Function(String)? dropdownSearchBox;
  final Function(String)? dropdownSearchOnSubmit;
  final Function()? dropdowmOntap;
  final int? maxLeght;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  const InputFieldWidget(
      {super.key,
      required this.textEditingController,
      required this.labelText,
      required this.hintText,
      required this.errorMsgText,
      this.keyboardTextInputType,
      this.preffixIcon,
      this.suffixIcon,
      this.isDropdownType,
      this.dropdownSelected,
      this.dropdownItems,
      this.dropdownOnChange,
      this.maxLinesText,
      this.dropdownSearchBox,
      this.dropdowmOntap,
      this.dropdownSearchOnSubmit,
      this.dropdownGlobalKey,
      this.focusNode,
      this.isEnabeledField,
      this.isRadOnlyField,
      this.isPasswordField,
      this.isStringDataTypeDropdown,
      this.maxLeght,
      this.inputFormatters,
      this.textInputAction});

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  // bool
  bool _obsPassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            width: double.infinity,
            child: Text(
              widget.labelText,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          widget.isDropdownType != null
              ? widget.isStringDataTypeDropdown ?? false
                  ? DropdownButtonFormField<dynamic>(
                      onTap: widget.dropdowmOntap,
                      value: widget.dropdownSelected,
                      items: widget.dropdownItems!.map((dynamic value) {
                        return DropdownMenuItem<dynamic>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: widget.dropdownOnChange,
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                      decoration: inputDecorationWidget(
                        hintText: widget.hintText,
                        prefixIcon: widget.preffixIcon,
                        suffixIcon: widget.suffixIcon,
                      ),
                    )
                  : DropdownButtonFormField<dynamic>(
                      onTap: widget.dropdowmOntap,
                      value: widget.dropdownSelected,
                      items: widget.dropdownItems!.map((dynamic value) {
                        return DropdownMenuItem<dynamic>(
                          value: value,
                          child: Text(value.name.toString()),
                        );
                      }).toList(),
                      onChanged: widget.dropdownOnChange,
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                      decoration: inputDecorationWidget(
                        hintText: widget.hintText,
                        prefixIcon: widget.preffixIcon,
                        suffixIcon: widget.suffixIcon,
                      ),
                    )
              : TextFormField(
                  controller: widget.textEditingController,
                  validator: (value) {
                    if (value == "") {
                      return widget.errorMsgText;
                    }
                    return null;
                  },
                  maxLines: widget.maxLinesText ?? 1,
                  maxLength: widget.maxLeght,
                  keyboardType: widget.keyboardTextInputType,
                  inputFormatters: widget.inputFormatters,
                  style: const TextStyle(fontSize: 13),
                  readOnly: widget.isRadOnlyField ?? false,
                  textInputAction: widget.textInputAction,
                  obscureText:
                      widget.isPasswordField ?? false ? _obsPassword : false,
                  decoration: inputDecorationWidget(
                    hintText: widget.hintText,
                    prefixIcon: widget.preffixIcon,
                    suffixIcon: widget.isPasswordField ?? false
                        ? IconButton(
                            onPressed: () {
                              _toggleObscured();
                            },
                            icon: Icon(
                              _obsPassword
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              size: 24,
                            ))
                        : widget.suffixIcon,
                  ),
                ),
        ],
      ),
    );
  }

  // local input decoration widget
  InputDecoration inputDecorationWidget(
      {Icon? prefixIcon, IconButton? suffixIcon, String? hintText}) {
    return InputDecoration(
      enabled: widget.isEnabeledField ?? true,
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorPalleteHelper.error)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorPalleteHelper.gray),
      ),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorPalleteHelper.gray)),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorPalleteHelper.error),
      ),
      contentPadding: const EdgeInsets.all(16),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
      border: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorPalleteHelper.gray)),
      counterText: '',
    );
  }

  //toggle change obscure password
  void _toggleObscured() {
    setState(() {
      _obsPassword == true ? _obsPassword = false : _obsPassword = true;
    });
  }
}
