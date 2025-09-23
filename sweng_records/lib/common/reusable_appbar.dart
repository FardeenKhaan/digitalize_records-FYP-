import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sweng_records/utils/constants/sizes.dart';
import 'package:sweng_records/utils/device/device_utility.dart';

class FkAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Color? backgroundColor;

  const FkAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(FkDeviceUtils.getAppBarHeight());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: FkSizes.sm),
      child: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        leading:
            showBackArrow
                ? IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left))
                : leadingIcon != null
                ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
                : null,

        title: title,

        actions: actions,
      ),
    );
  }
}
