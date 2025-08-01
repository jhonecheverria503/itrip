import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:itrip/data/model/trip.dart';
import 'package:itrip/ui/widget/common/app_bar_primary.dart';
import 'package:itrip/ui/widget/common/button_link.dart';
import 'package:itrip/ui/widget/common/button_primary.dart';
import 'package:itrip/use_cases/bloc/trip_bloc/trip_bloc.dart';
import 'package:itrip/util/constants.dart';

class RecordTripView extends StatefulWidget {
  final Trip trip;
  const RecordTripView({super.key, required this.trip});

  @override
  State<RecordTripView> createState() => _RecordTripViewState();
}

class _RecordTripViewState extends State<RecordTripView> {
  final ValueNotifier<Position?> _position = ValueNotifier(null);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(13.7012837, -89.2244333),
    zoom: 15,
  );

  Future<void> getCurrentLocation() async {
    _position.value = await Geolocator.getCurrentPosition();
    moveCamera();
  }

  void currentLocationLive() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position? position) async {
            _position.value = position;
            moveCamera();
          },
        );
  }

  Future<void> moveCamera() async {
    GoogleMapController gMapCtrl = await _controller.future;
    gMapCtrl.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _position.value?.latitude ?? 0,
            _position.value?.longitude ?? 0,
          ),
          zoom: 15.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      currentLocationLive();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPrimary(context: context),
      body: SafeArea(
        child: BlocListener<TripBloc, TripState>(
          listener: (context, state) {
            if (state is TripUpdatedState) {
              BlocProvider.of<TripBloc>(context).add(LoadTripsEvent());
              Navigator.pop(context);
            }
          },
          child: ValueListenableBuilder(
            valueListenable: _position,
            builder: (BuildContext context, value, Widget? child) {
              return Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: _cameraPosition,
                      myLocationEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.trip.name,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: ButtonPrimary(
                                onClick: () async {
                                  await getCurrentLocation();
                                  BlocProvider.of<TripBloc>(
                                    Constants.navigatorKey.currentContext!,
                                  ).add(
                                    UpdateTripEvent(
                                      latitude: _position.value!.latitude,
                                      longitude: _position.value!.longitude,
                                    ),
                                  );
                                },
                                text: "Capturar Momento",
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                height: 52,
                                child: ButtonLink(
                                  onClick: () {
                                    Navigator.pop(context);
                                  },
                                  text: "Finalizar",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: () {
          getCurrentLocation();
        },
      ),
    );
  }
}
