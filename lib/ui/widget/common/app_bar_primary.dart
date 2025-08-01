import 'package:flutter/material.dart';
import 'package:itrip/util/colors_app.dart';

class AppBarPrimary extends PreferredSize {
  final BuildContext context;
  final bool showBack;
  AppBarPrimary({super.key, required this.context, this.showBack = false})
    : super(
        child: const SizedBox(),
        preferredSize: MediaQuery.of(context).size,
      );

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: MediaQuery.sizeOf(context),
      child: DecoratedBox(
        decoration: BoxDecoration(color: ColorsApp.primaryColor),
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16.0),
              child: Row(
                children: [
                  Visibility(
                    visible: showBack,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.only(right: 16),
                      color: Colors.black,
                    ),
                  ),
                  Image.asset("asset/images/itrip_logo.png", width: 130),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
