import 'package:flutter/material.dart';
import 'package:itrip/util/colors_app.dart';

class TextFieldPrimary extends StatefulWidget {
  const TextFieldPrimary({
    super.key,
    this.controller,
    this.autofillHints,
    required this.labelText,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.obscureText = false,
    this.focusNode,
    this.maxLines = 1,
  });
  final TextEditingController? controller;
  final Iterable<String>? autofillHints;
  final String labelText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool obscureText;
  final FocusNode? focusNode;
  final int? maxLines;

  @override
  State<TextFieldPrimary> createState() => _TextFieldPrimaryState();
}

class _TextFieldPrimaryState extends State<TextFieldPrimary> {
  Color? _focusColor;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (widget.focusNode != null) {
        _focusNode = widget.focusNode!;
      }
      _focusNode.addListener(() {
        setState(() {
          _focusColor = _focusNode.hasFocus ? ColorsApp.primaryDarkColor : null;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      autofillHints: widget.autofillHints,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: _focusColor),
        alignLabelWithHint: true,
        // floatingLabelStyle: TextStyle(color: ColorsApp.primaryDarkColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: ColorsApp.primaryColor, width: 2.0),
        ),
      ),
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: (v) {
        if (widget.validator != null) {
          return widget.validator!(v);
        }
        return null;
      },
      maxLines: widget.maxLines,
      minLines: widget.maxLines ?? 1,
    );
  }
}
