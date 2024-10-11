import 'package:dmb_app/utils/color_pallete_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable input field widget that supports both text input and dropdown selection.
///
/// This widget allows you to create a text input field or a dropdown field with various customization options.
class InputFieldWidget extends StatefulWidget {
  final TextEditingController
      textEditingController; // Controller for managing text input
  final String labelText; // Label text for the input field
  final String hintText; // Placeholder text for the input field
  final int? maxLinesText; // Maximum number of lines for text input
  final String errorMsgText; // Error message text if validation fails
  final TextInputType?
      keyboardTextInputType; // Keyboard type for the input field
  final Icon? preffixIcon; // Icon displayed at the start of the input field
  final IconButton? suffixIcon; // Icon displayed at the end of the input field
  final bool? isDropdownType; // Flag indicating if the input is a dropdown
  final dynamic dropdownSelected; // Selected value for the dropdown
  final List<dynamic>? dropdownItems; // Items to be displayed in the dropdown
  final GlobalKey? dropdownGlobalKey; // Global key for dropdown (if needed)
  final FocusNode? focusNode; // Focus node for input field
  final bool? isEnabeledField; // Flag indicating if the field is enabled
  final bool? isRadOnlyField; // Flag for read-only field
  final bool? isPasswordField; // Flag for password input field
  final bool? isStringDataTypeDropdown; // Flag for string data type in dropdown
  final Function(dynamic)?
      dropdownOnChange; // Callback for dropdown value change
  final Function(String)?
      dropdownSearchBox; // Callback for searching in dropdown
  final Function(String)?
      dropdownSearchOnSubmit; // Callback for search submission
  final Function()? dropdowmOntap; // Callback for dropdown tap event
  final int? maxLeght; // Maximum length of input
  final List<TextInputFormatter>? inputFormatters; // Formatters for input
  final TextInputAction? textInputAction; // Action for the text input

  const InputFieldWidget({
    super.key,
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
    this.textInputAction,
  });

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool _obsPassword = true; // Obscured text state for password input

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Label for the input field
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            width: double.infinity,
            child: Text(
              widget.labelText,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          // Render dropdown or text input based on the isDropdownType flag
          widget.isDropdownType != null
              ? _buildDropdownField()
              : _buildTextField(),
        ],
      ),
    );
  }

  /// Builds the dropdown field widget.
  Widget _buildDropdownField() {
    return DropdownButtonFormField<dynamic>(
      onTap: widget.dropdowmOntap,
      value: widget.dropdownSelected,
      items: widget.dropdownItems!.map((dynamic value) {
        return DropdownMenuItem<dynamic>(
          value: value,
          child: Text(
            widget.isStringDataTypeDropdown ?? false
                ? value.toString()
                : value.name.toString(),
          ),
        );
      }).toList(),
      onChanged: widget.dropdownOnChange,
      style: const TextStyle(fontSize: 13, color: Colors.black),
      decoration: _inputDecorationWidget(
        hintText: widget.hintText,
        prefixIcon: widget.preffixIcon,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }

  /// Builds the text input field widget.
  Widget _buildTextField() {
    return TextFormField(
      controller: widget.textEditingController,
      validator: (value) {
        if (value == "") {
          return widget
              .errorMsgText; // Return error message if validation fails
        }
        return null; // No error
      },
      maxLines: widget.maxLinesText ?? 1,
      maxLength: widget.maxLeght,
      keyboardType: widget.keyboardTextInputType,
      inputFormatters: widget.inputFormatters,
      style: const TextStyle(fontSize: 13),
      readOnly: widget.isRadOnlyField ?? false,
      textInputAction: widget.textInputAction,
      obscureText: widget.isPasswordField ?? false ? _obsPassword : false,
      decoration: _inputDecorationWidget(
        hintText: widget.hintText,
        prefixIcon: widget.preffixIcon,
        suffixIcon: widget.isPasswordField ?? false
            ? IconButton(
                onPressed: _toggleObscured,
                icon: Icon(
                  _obsPassword
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  size: 24,
                ),
              )
            : widget.suffixIcon,
      ),
    );
  }

  /// Creates input decoration for the text field.
  InputDecoration _inputDecorationWidget({
    Icon? prefixIcon,
    IconButton? suffixIcon,
    String? hintText,
  }) {
    return InputDecoration(
      enabled: widget.isEnabeledField ?? true,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorPalleteHelper.error),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorPalleteHelper.gray),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorPalleteHelper.gray),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorPalleteHelper.error),
      ),
      contentPadding: const EdgeInsets.all(16),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalleteHelper.gray),
      ),
      counterText: '',
    );
  }

  /// Toggles the obscured state of the password input.
  void _toggleObscured() {
    setState(() {
      _obsPassword = !_obsPassword; // Toggle password visibility
    });
  }
}
