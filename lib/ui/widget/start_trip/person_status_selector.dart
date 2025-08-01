import 'package:flutter/material.dart';
import 'package:itrip/data/enum/person_status_enum.dart';
import 'package:itrip/util/colors_app.dart';

class PersonStatusSelector extends StatelessWidget {
  const PersonStatusSelector({
    super.key,
    required this.personStatus,
    required this.isSelected,
  });
  final PersonStatusEnum personStatus;
  final bool isSelected;

  String imageAssetByPersonStatus() {
    String label = "";
    switch (personStatus) {
      case PersonStatusEnum.individual:
        label = "asset/images/alone.png";
        break;
      case PersonStatusEnum.companied:
        label = "asset/images/companied.png";
        break;
    }
    return label;
  }

  String labelByPersonStatus() {
    String label = "";
    switch (personStatus) {
      case PersonStatusEnum.individual:
        label = "Individual";
        break;
      case PersonStatusEnum.companied:
        label = "Acompañad@";
        break;
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12.00),
        side: BorderSide(
          color: isSelected ? ColorsApp.primaryDarkColor : Colors.black,
          width: 2.00,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset(imageAssetByPersonStatus()),
            const SizedBox(height: 10.00),
            Text(labelByPersonStatus()),
          ],
        ),
      ),
    );
  }
}
