import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itrip/data/enum/person_status_enum.dart';
import 'package:itrip/ui/view/record_trip_view.dart';
import 'package:itrip/ui/widget/common/app_bar_primary.dart';
import 'package:itrip/ui/widget/common/button_primary.dart';
import 'package:itrip/ui/widget/common/text_field_primary.dart';
import 'package:itrip/ui/widget/start_trip/person_status_selector.dart';
import 'package:itrip/use_cases/bloc/trip_bloc/trip_bloc.dart';
import 'package:itrip/util/extension/person_status_extension.dart';

class StartTripView extends StatefulWidget {
  const StartTripView({super.key});

  @override
  State<StartTripView> createState() => _StartTripViewState();
}

class _StartTripViewState extends State<StartTripView> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _ctrlName = TextEditingController();
  final TextEditingController _ctrlDescription = TextEditingController();
  final ValueNotifier<String> personStatus = ValueNotifier(
    PersonStatusEnum.individual.getValue(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPrimary(context: context, showBack: true),
      body: BlocListener<TripBloc, TripState>(
        listener: (context, state) {
          if (state is TripStartedState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => RecordTripView(trip: state.trip),
              ),
              (Route<dynamic> r) => r.isFirst,
            );
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, //pa poner todo a la izquierda
                  children: [
                    Text(
                      "Iniciar Paseo 🏖️",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Información Basica",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFieldPrimary(
                      labelText: "Nombre de la aventura",
                      controller: _ctrlName,
                      validator: (p0) {
                        return (p0 ?? "").isNotEmpty ? null : "Camo Requerido";
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldPrimary(
                      labelText: "Descripcion de tu recorrido",
                      maxLines: 5,
                      controller: _ctrlDescription,
                      validator: (p0) {
                        return (p0 ?? "").isNotEmpty ? null : "Camo Requerido";
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "¿Como es tu paseo en ésta ocasion?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder(
                      valueListenable: personStatus,
                      builder: (context, value, child) {
                        return FormField<String>(
                          initialValue: personStatus.value,
                          onSaved: (newValue) =>
                              personStatus.value = newValue ?? "",
                          builder: (field) {
                            return Row(
                              children: PersonStatusEnum.values
                                  .map(
                                    (ps) => GestureDetector(
                                      onTap: () =>
                                          personStatus.value = ps.getValue(),
                                      child: PersonStatusSelector(
                                        personStatus: ps,
                                        isSelected:
                                            personStatus.value == ps.getValue(),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
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
                        onClick: () async {
                          if (_keyForm.currentState!.validate()) {
                            BlocProvider.of<TripBloc>(context).add(
                              StartTripEvent(
                                name: _ctrlName.text,
                                description: _ctrlDescription.text,
                                personStatusValue: personStatus.value,
                              ),
                            );
                          }
                        },
                        text: "Empezar Paseo",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
