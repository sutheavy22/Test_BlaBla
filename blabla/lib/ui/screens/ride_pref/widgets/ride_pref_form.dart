import 'package:blabla/services/locations_service.dart';
import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';
 
import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
 
///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  Location? arrival;
  DateTime departureDate = DateTime.now();
  int requestedSeats = 1;


  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
   void initState() {
    super.initState();
    // TODO
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    }
  }
   bool get isValid =>
      departure != null && arrival != null && requestedSeats > 0;

  // ----------------------------------
  // Handle events
  // ----------------------------------
 

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<Location>(
          value: departure,
          hint: const Text("Leaving from"),
          items: LocationsService.availableLocations
              .map(
                (loc) => DropdownMenuItem(
                  value: loc,
                  child: Text("${loc.name}, ${loc.country.name}"),
                ),
              )
              .toList(),
          onChanged: (v) => setState(() => departure = v),
        ),

        const SizedBox(height: 12),

        DropdownButtonFormField<Location>(
          value: arrival,
          hint: const Text("Going to"),
          items: LocationsService.availableLocations
              .map(
                (loc) => DropdownMenuItem(
                  value: loc,
                  child: Text("${loc.name}, ${loc.country.name}"),
                ),
              )
              .toList(),
          onChanged: (v) => setState(() => arrival = v),
        ),

        const SizedBox(height: 12),

        TextFormField(
          decoration: const InputDecoration(labelText: "Seats"),
          keyboardType: TextInputType.number,
          initialValue: "1",
          onChanged: (v) =>
              setState(() => requestedSeats = int.tryParse(v) ?? 1),
        ),

        const SizedBox(height: 16),

        BlaButton(label: "Search", onPressed: isValid ? () {} : null),
      ],
    );
  }
}
