import 'package:beye_group/shared/widgets/main_text.dart';
import 'package:beye_group/singletons/app_colors.dart';
import 'package:beye_group/singletons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomTab extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const CustomTab({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0.r),
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: MainText(
                text: title,
                fontSize: 14.spMin,
                color: AppColors.lightGrey,
              ),
            ),
            SvgPicture.asset(
              AppIcons.arrowDown,
              colorFilter:
                  const ColorFilter.mode(AppColors.lightGrey, BlendMode.srcIn),
            )
          ],
        ),
      ),
    );
  }
}
