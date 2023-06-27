import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:uuid/uuid.dart';

import 'main.dart';

// custom scaffold that handle search
// basically your widget need to extends [GooglePlacesAutocompleteWidget]
// and your state [GooglePlacesAutocompleteState]
class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold({Key? key})
      : super(
          key: key,
          apiKey: kGoogleApiKey,
          sessionToken: const Uuid().v4(),
          language: 'en',
          components: [const Component(Component.country, 'uk')],
        );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarPlacesAutoCompleteTextField(
          textStyle: null,
          textDecoration: null,
          cursorColor: null,
        ),
      ),
      body: PlacesAutocompleteResult(
        onTap: (p) => displayPrediction(p, ScaffoldMessenger.of(context)),
        logo: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [FlutterLogo()],
        ),
        resultTextStyle: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage ?? 'Unknown error')),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);

    if (response.predictions.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Got answer')),
      );
    }
  }
}
