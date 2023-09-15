import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/color_constnts.dart';
import '../constants/text_styles.dart';

class AppTextField extends StatelessWidget {
  final TextInputType? textInputType;
  final TextAlign textAlign;
  final String hintText;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final String? prefixText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? functionValidate;
  final void Function(String)? functionOnTextChange;
  final String? parametersValidate;
  final TextInputAction actionKeyboard;
  final TextCapitalization textCapitalization;
  final Function? onSubmitField;
  final Function? onFieldTap;
  final String? errorText;
  final int? maxLength;
  final int? maxLines;
  final bool isOutlineBorder;
  final Color enabledBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool isEnabled;
  final List<TextInputFormatter>? inputFormatters;
  final GlobalKey<FormState>? formKey;

  const AppTextField(
      {Key? key,
        required this.hintText,
        this.focusNode,
        this.textInputType,
        this.textAlign = TextAlign.start,
        this.obscureText = false,
        this.controller,
        this.functionValidate,
        this.functionOnTextChange,
        this.parametersValidate,
        this.actionKeyboard = TextInputAction.next,
        this.textCapitalization = TextCapitalization.none,
        this.onSubmitField,
        this.formKey,
        this.onFieldTap,
        this.prefixIcon,
        this.prefixIconConstraints,
        this.prefixText,
        this.suffixIcon,
        this.errorText,
        this.maxLength,
        this.maxLines,
        this.isOutlineBorder = false,
        this.enabledBorderColor = ColorConstants.greyScaleDark6,
        this.contentPadding,
        this.isEnabled = true,
        this.inputFormatters})
      : super(key: key);

  static const double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // accentColor: Palette.colorActionableText,
        primaryColor: ColorConstants.greyScaleDark6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(hintText, style: textStyles.smTextRegularStyle.copyWith(color: ColorConstants.greyScaleDark5),),
          TextFormField(
            cursorColor: ColorConstants.primaryColor,
            obscureText: obscureText,
            keyboardType: textInputType,
            textAlign: textAlign,
            textInputAction: actionKeyboard,
            textCapitalization: textCapitalization,
            focusNode: focusNode,
            enabled: isEnabled,
            maxLength: maxLength,
            maxLines: obscureText ? 1 : maxLines,
            inputFormatters: const [
            ],
            style: textStyles.mdTextRegularStyle
                .copyWith(color: ColorConstants.greyScaleDark1),
            decoration: InputDecoration(
              //counterStyle: Put Style here,
                prefixIcon: prefixIcon,
                prefixIconConstraints: prefixIconConstraints ?? const BoxConstraints(
                  minWidth: 30,
                  minHeight: 15,
                ),
                prefixText: prefixText,
                suffixIcon: suffixIcon,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 15,
                ),
                // hintText: hintText,
                labelText: hintText,
                enabledBorder: isOutlineBorder
                    ? OutlineInputBorder(
                  borderSide:
                  BorderSide(color: enabledBorderColor, width: 0.8),
                )
                    : UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: enabledBorderColor, width: 0.8),
                ),
                focusedBorder: isOutlineBorder
                    ? const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorConstants.primaryColor, width: 1),
                )
                    : const UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorConstants.primaryColor, width: 1),
                ),
                /*enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.colorPrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.colorPrimary),
              ),*/
                // hintStyle: textStyles.smTextRegularStyle.copyWith(color: ColorConstants.greyScaleDark5),
                labelStyle: textStyles.mdTextRegularStyle
                    .copyWith(color: ColorConstants.greyScaleDark5),
                contentPadding: contentPadding ??
                    const EdgeInsets.only(
                        top: 12,
                        bottom: bottomPaddingToError,
                        left: 0.0,
                        right: 0.0),
                isDense: true,
                errorStyle: textStyles.smTextRegularStyle
                    .copyWith(color: ColorConstants.statusColoursRed0),
                errorBorder: isOutlineBorder
                    ? OutlineInputBorder(
                  borderSide:
                  BorderSide(color: enabledBorderColor, width: 0.8),
                )
                    : UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: enabledBorderColor, width: 0.8),
                ),
                focusedErrorBorder: isOutlineBorder
                    ? OutlineInputBorder(
                  borderSide:
                  BorderSide(color: enabledBorderColor, width: 1),
                )
                    : UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: enabledBorderColor, width: 1),
                ),
                errorText: errorText
              /*errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.colorPrimary),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.colorPrimary),
              ),*/
            ),
            controller: controller,
            validator: functionValidate,
            onFieldSubmitted: (value) {
              if (onSubmitField != null) onSubmitField!();
            },
            onTap: () {
              if (onFieldTap != null) onFieldTap!();
            },
            onChanged: functionOnTextChange,
          ),
        ],
      ),
    );
  }

  String? commonValidation(String value, String messageError) {
    var required = requiredValidator(value, messageError);
    if (required != null) {
      return required;
    }
    return null;
  }

  String? requiredValidator(value, messageError) {
    if (value.isEmpty) {
      return messageError;
    }
    return null;
  }

  void changeFocus(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
