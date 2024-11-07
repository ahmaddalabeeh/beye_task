import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final double? height;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final List<Shadow>? shadow;

  const MainText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.height,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.shadow,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle baseStyle = theme.textTheme.bodyLarge?.copyWith(
          letterSpacing: letterSpacing ?? 0,
          color: color ?? Colors.black,
          fontSize: fontSize ?? 16.spMin,
          fontWeight: fontWeight ?? FontWeight.w400,
          height: height,
          shadows: shadow,
          decoration: decoration,
          decorationColor: color ?? theme.textTheme.bodyLarge?.color,
        ) ??
        const TextStyle();

    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: baseStyle,
    );
  }
}
