import 'package:flutter/material.dart';
import 'package:itrip/data/model/trip.dart';
import 'package:itrip/ui/view/detail_trip_view.dart';
import 'package:itrip/ui/widget/common/theme_helper.dart';
import 'package:itrip/util/colors_app.dart';

class TripCardPortrait extends StatefulWidget {
  final Trip trip;
  const TripCardPortrait({super.key, required this.trip});

  @override
  State<TripCardPortrait> createState() => _TripCardPortraitState();
}

class _TripCardPortraitState extends State<TripCardPortrait> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailTripView(trip: widget.trip),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.cyan,
        ),
        child: SizedBox(
          width: 172,
          height: 206,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Column(
              children: [
                Spacer(),
                Card(
                  color: ThemeHelper.darkModeActive()
                      ? Color(0xFF1D1B20)
                      : Color(0xE8E8E8CC),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.trip.name,
                          style: TextStyle(
                            // color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
                          children: [
                            Icon(Icons.tour, color: ColorsApp.primaryColor),
                            Text(
                              "1 Recuerdo",
                              // style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
