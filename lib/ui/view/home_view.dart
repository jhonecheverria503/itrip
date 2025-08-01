import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itrip/data/model/trip.dart';
import 'package:itrip/ui/view/start_trip_view.dart';
import 'package:itrip/ui/widget/common/app_bar_primary.dart';
import 'package:itrip/ui/widget/common/button_primary.dart';
import 'package:itrip/ui/widget/home/trip_card_portrait.dart';
import 'package:itrip/use_cases/bloc/trip_bloc/trip_bloc.dart';
import 'package:itrip/use_cases/singleton/session_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      BlocProvider.of<TripBloc>(context).add(LoadTripsEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPrimary(context: context),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "¡Hola ${SessionManager.getInstance().getName()}! 👋",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(100.0),
                      child: Image.network(
                        SessionManager.getInstance().getPhotoUrl() ?? "",
                        width: 64,
                        height: 64,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                BlocBuilder<TripBloc, TripState>(
                  builder: (context, state) {
                    List<Trip> tripList = BlocProvider.of<TripBloc>(
                      context,
                    ).tripList;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: tripList
                            .map(
                              (t) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TripCardPortrait(trip: t),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 8,
                    bottom: 32.0,
                  ),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: ButtonPrimary(
                      onClick: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const StartTripView(),
                          ),
                        );
                      },
                      text: "Iniciar Paseo",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
