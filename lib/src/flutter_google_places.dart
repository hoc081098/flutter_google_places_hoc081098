library flutter_google_places_hoc081098.src;

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:http/http.dart';
import 'package:listenable_stream/listenable_stream.dart';
import 'package:rxdart_ext/single.dart';
import 'package:rxdart_ext/state_stream.dart';

import 'google_maps_webservice/places.dart';

class PlacesAutocompleteWidget extends StatefulWidget {
  /// The API key to use for the Places API.
  final String? apiKey;

  /// The mode of the autocomplete widget.
  final Mode mode;

  /// The hint text to show in the search field.
  /// Default is 'Search'.
  final String? hint;

  /// The initial text to show in the search field.
  final String? startText;

  /// The BorderRadius used for the dialog in [Mode.overlay].
  final BorderRadius? overlayBorderRadius;

  /// The point around which to retrieve place information.
  /// The [radius] parameter must also be provided when specifying a location.
  /// If [radius] is not provided, the location parameter is ignored.
  ///
  /// See [autocomplete docs](https://developers.google.com/maps/documentation/places/web-service/autocomplete#location).
  final Location? location;

  /// The origin point from which to calculate straight-line distance
  /// to the destination (returned as distance_meters).
  /// If this value is omitted, straight-line distance will not be returned.
  ///
  /// See [autocomplete docs](https://developers.google.com/maps/documentation/places/web-service/autocomplete#origin).
  final Location? origin;

  /// The position, in the input term, of the last character that the service uses to match predictions.
  ///
  /// For example, if the input is Google and the offset is 3, the service will match on Goo.
  /// The string determined by the offset is matched against the first word in the input term only.
  /// For example, if the input term is Google abc and the offset is 3,
  /// the service will attempt to match against Goo abc.
  ///
  /// If no offset is supplied, the service will use the whole term.
  /// The offset should generally be set to the position of the text caret.
  ///
  /// See [autocomplete docs](https://developers.google.com/maps/documentation/places/web-service/autocomplete#offset).
  final num? offset;

  /// Defines the distance (in meters) within which to return place results.
  /// You may bias results to a specified circle by passing a location and a radius parameter.
  ///
  /// Doing so instructs the Places service to prefer showing results within that circle;
  /// results outside of the defined area may still be displayed.
  ///
  /// See [autocomplete docs](https://developers.google.com/maps/documentation/places/web-service/autocomplete#radius).
  final num? radius;

  /// The language in which to return results.
  ///
  /// See [autocomplete docs](https://developers.google.com/places/web-service/autocomplete#language).
  final String? language;

  /// A random string which identifies an autocomplete session for billing purposes.
  ///
  /// See [autocomplete docs](https://developers.google.com/maps/documentation/places/web-service/autocomplete#sessiontoken).
  final String? sessionToken;

  /// You can restrict results from a Place Autocomplete request
  /// to be of a certain type by passing the types parameter.
  ///
  /// This parameter specifies a type or a type collection, as listed in Place Types.
  /// If nothing is specified, all types are returned.
  ///
  /// See [autocomplete docs](https://developers.google.com/maps/documentation/places/web-service/autocomplete#types).
  final List<String>? types;

  /// A grouping of places to which you would like to restrict your results.
  /// Currently, you can use components to filter by up to 5 countries.
  /// Countries must be passed as a two character, ISO 3166-1 Alpha-2 compatible country code.
  ///
  /// See [autocomplete docs](https://developers.google.com/maps/documentation/places/web-service/autocomplete#components).
  final List<Component>? components;

  /// Returns only those places that are strictly within the region defined by location and radius.
  /// This is a restriction, rather than a bias, meaning that
  /// results outside this region will not be returned even if they match the user input.
  ///
  /// See [autocomplete docs](https://developers.google.com/maps/documentation/places/web-service/autocomplete#strictbounds).
  final bool? strictbounds;

  /// The region code, specified as a ccTLD ("top-level domain") two-character value.
  /// Most ccTLD codes are identical to ISO 3166-1 codes, with some notable exceptions.
  ///
  /// See [autocomplete docs](https://developers.google.com/maps/documentation/places/web-service/autocomplete#region).
  final String? region;

  /// The logo to display.
  /// Default is the `powered by Google` logo.
  final Widget? logo;

  /// The callback will be called when the autocomplete has an error.
  final ValueChanged<PlacesAutocompleteResponse>? onError;

  /// The debounce time for the search query.
  /// Default is 300ms.
  final Duration? debounce;

  /// The additional HTTP headers to send with the request,
  /// along with the headers from `google_api_headers`.
  final Map<String, String>? headers;

  /// This defines the space between the screen's edges and the dialog.
  /// This is only used in Mode.overlay.
  final EdgeInsets? insetPadding;

  /// The back arrow icon in the leading of the appbar.
  /// This is only used in [Mode.overlay].
  ///
  /// If not provided, the following icons will be used:
  /// - [Icons.arrow_back_ios] will be used on iOS
  /// - [Icons.arrow_back] on other platforms.
  final Widget? backArrowIcon;

  /// Decoration for search text field
  final InputDecoration? textDecoration;

  /// Text style for search text field
  final TextStyle? textStyle;

  /// The color of the cursor of the search text field.
  final Color? cursorColor;

  /// optional - sets 'proxy' value in google_maps_webservice
  ///
  /// In case of using a proxy the baseUrl can be set.
  /// The apiKey is not required in case the proxy sets it.
  /// (Not storing the apiKey in the app is good practice)
  final String? proxyBaseUrl;

  /// optional - set 'client' value in google_maps_webservice
  ///
  /// In case of using a proxy url that requires authentication
  /// or custom configuration
  final Client? httpClient;

  /// Text style for each result's text.
  final TextStyle? resultTextStyle;

  PlacesAutocompleteWidget(
      {Key? key,
      required this.apiKey,
      this.mode = Mode.fullscreen,
      this.hint = 'Search',
      this.insetPadding,
      this.backArrowIcon,
      this.overlayBorderRadius,
      this.offset,
      this.location,
      this.origin,
      this.radius,
      this.language,
      this.sessionToken,
      this.types,
      this.components,
      this.strictbounds,
      this.region,
      this.logo,
      this.onError,
      this.proxyBaseUrl,
      this.httpClient,
      this.startText,
      this.debounce,
      this.headers,
      this.textDecoration,
      this.textStyle,
      this.cursorColor,
      this.resultTextStyle})
      : super(key: key) {
    if (apiKey == null && proxyBaseUrl == null) {
      throw ArgumentError(
          'One of `apiKey` and `proxyBaseUrl` fields is required');
    }
  }

  @override
  // ignore: no_logic_in_create_state
  State<PlacesAutocompleteWidget> createState() => mode == Mode.fullscreen
      ? _PlacesAutocompleteScaffoldState()
      : _PlacesAutocompleteOverlayState();

  static PlacesAutocompleteState of(BuildContext context) =>
      context.findAncestorStateOfType<PlacesAutocompleteState>()!;
}

class _PlacesAutocompleteScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: AppBarPlacesAutoCompleteTextField(
        textDecoration: widget.textDecoration,
        textStyle: widget.textStyle,
        cursorColor: widget.cursorColor,
      ),
    );
    final body = PlacesAutocompleteResult(
      onTap: Navigator.of(context).pop,
      logo: widget.logo,
      resultTextStyle: widget.resultTextStyle,
    );
    return Scaffold(appBar: appBar, body: body);
  }
}

class _PlacesAutocompleteOverlayState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final headerTopLeftBorderRadius =
        widget.overlayBorderRadius?.topLeft ?? const Radius.circular(2);

    final headerTopRightBorderRadius =
        widget.overlayBorderRadius?.topRight ?? const Radius.circular(2);

    final header = Column(children: <Widget>[
      Material(
          color: theme.dialogBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: headerTopLeftBorderRadius,
              topRight: headerTopRightBorderRadius),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                padding: const EdgeInsets.all(8.0).copyWith(top: 12.0),
                color: theme.brightness == Brightness.light
                    ? Colors.black45
                    : null,
                icon: _iconBack,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 10.0),
                  child: _textField(context),
                ),
              ),
            ],
          )),
      const Divider(),
    ]);

    final bodyBottomLeftBorderRadius =
        widget.overlayBorderRadius?.bottomLeft ?? const Radius.circular(2);

    final bodyBottomRightBorderRadius =
        widget.overlayBorderRadius?.bottomRight ?? const Radius.circular(2);

    final container = Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
      child: Stack(
        children: <Widget>[
          header,
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: RxStreamBuilder<_SearchState>(
              stream: _state$,
              builder: (context, state) {
                final response = state.response;

                if (state.isSearching) {
                  return Stack(
                    alignment: FractionalOffset.bottomCenter,
                    children: <Widget>[_Loader()],
                  );
                } else if (state.text.isEmpty ||
                    response == null ||
                    response.predictions.isEmpty) {
                  return Material(
                    color: theme.dialogBackgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: bodyBottomLeftBorderRadius,
                      bottomRight: bodyBottomRightBorderRadius,
                    ),
                    child: widget.logo ?? const PoweredByGoogleImage(),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Material(
                      borderRadius: BorderRadius.only(
                        bottomLeft: bodyBottomLeftBorderRadius,
                        bottomRight: bodyBottomRightBorderRadius,
                      ),
                      color: theme.dialogBackgroundColor,
                      child: ListBody(
                        children: response.predictions
                            .map(
                              (p) => PredictionTile(
                                prediction: p,
                                onTap: Navigator.of(context).pop,
                                resultTextStyle: widget.resultTextStyle,
                              ),
                            )
                            .toList(growable: false),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return Padding(
          padding: widget.insetPadding ?? const EdgeInsets.only(top: 8.0),
          child: container);
    }

    return Padding(
      padding: widget.insetPadding ?? EdgeInsets.zero,
      child: container,
    );
  }

  Widget get _iconBack {
    if (widget.backArrowIcon != null) return widget.backArrowIcon!;
    return Theme.of(context).platform == TargetPlatform.iOS
        ? const Icon(Icons.arrow_back_ios)
        : const Icon(Icons.arrow_back);
  }

  Widget _textField(BuildContext context) => TextField(
        controller: _queryTextController,
        autofocus: true,
        style: widget.textStyle ??
            TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black87
                    : null,
                fontSize: 16.0),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black45
                : null,
            fontSize: 16.0,
          ),
          border: InputBorder.none,
        ),
      );
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 2.0),
      child: LinearProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

class PlacesAutocompleteResult extends StatelessWidget {
  final ValueChanged<Prediction> onTap;
  final Widget? logo;
  final TextStyle? resultTextStyle;

  const PlacesAutocompleteResult(
      {Key? key, required this.onTap, required this.logo, this.resultTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = PlacesAutocompleteWidget.of(context);

    return RxStreamBuilder<_SearchState>(
      stream: state._state$,
      builder: (context, state) {
        final response = state.response;

        if (state.text.isEmpty ||
            response == null ||
            response.predictions.isEmpty) {
          return Stack(
            children: [
              if (state.isSearching) _Loader(),
              logo ?? const PoweredByGoogleImage()
            ],
          );
        }
        return PredictionsListView(
          predictions: response.predictions,
          onTap: onTap,
          resultTextStyle: resultTextStyle,
        );
      },
    );
  }
}

class AppBarPlacesAutoCompleteTextField extends StatefulWidget {
  final InputDecoration? textDecoration;
  final TextStyle? textStyle;
  final Color? cursorColor;

  const AppBarPlacesAutoCompleteTextField({
    Key? key,
    required this.textDecoration,
    required this.textStyle,
    required this.cursorColor,
  }) : super(key: key);

  @override
  State<AppBarPlacesAutoCompleteTextField> createState() =>
      _AppBarPlacesAutoCompleteTextFieldState();
}

class _AppBarPlacesAutoCompleteTextFieldState
    extends State<AppBarPlacesAutoCompleteTextField> {
  @override
  Widget build(BuildContext context) {
    final state = PlacesAutocompleteWidget.of(context);

    return Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.only(top: 2.0),
        child: TextField(
          controller: state._queryTextController,
          autofocus: true,
          style: widget.textStyle ?? _defaultStyle(),
          decoration:
              widget.textDecoration ?? _defaultDecoration(state.widget.hint),
          cursorColor: widget.cursorColor,
        ));
  }

  InputDecoration _defaultDecoration(String? hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white30
          : Colors.black38,
      hintStyle: TextStyle(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black38
            : Colors.white30,
        fontSize: 16.0,
      ),
      border: InputBorder.none,
    );
  }

  TextStyle _defaultStyle() {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.black.withOpacity(0.9)
          : Colors.white.withOpacity(0.9),
      fontSize: 16.0,
    );
  }
}

class PoweredByGoogleImage extends StatelessWidget {
  final _poweredByGoogleWhite =
      'packages/flutter_google_places_hoc081098/assets/google_white.png';
  final _poweredByGoogleBlack =
      'packages/flutter_google_places_hoc081098/assets/google_black.png';

  const PoweredByGoogleImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            Theme.of(context).brightness == Brightness.light
                ? _poweredByGoogleWhite
                : _poweredByGoogleBlack,
            scale: 2.5,
          ))
    ]);
  }
}

class PredictionsListView extends StatelessWidget {
  final List<Prediction> predictions;
  final ValueChanged<Prediction> onTap;
  final TextStyle? resultTextStyle;

  const PredictionsListView(
      {Key? key,
      required this.predictions,
      required this.onTap,
      this.resultTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: predictions
          .map((Prediction p) => PredictionTile(
                prediction: p,
                onTap: onTap,
                resultTextStyle: resultTextStyle,
              ))
          .toList(growable: false),
    );
  }
}

class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  final ValueChanged<Prediction> onTap;
  final TextStyle? resultTextStyle;

  const PredictionTile(
      {Key? key,
      required this.prediction,
      required this.onTap,
      this.resultTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(
        prediction.description ?? '',
        style: resultTextStyle,
      ),
      onTap: () => onTap(prediction),
    );
  }
}

enum Mode { overlay, fullscreen }

abstract class PlacesAutocompleteState extends State<PlacesAutocompleteWidget> {
  late final TextEditingController _queryTextController =
      TextEditingController(text: widget.startText)
        ..selection = TextSelection(
          baseOffset: 0,
          extentOffset: widget.startText?.length ?? 0,
        );

  late final StateConnectableStream<_SearchState> _state$ =
      Single.fromCallable(() => const GoogleApiHeaders().getHeaders())
          .exhaustMap(createGoogleMapsPlaces)
          .exhaustMap(
            (places) => _queryTextController
                .toValueStream(replayValue: true)
                .map((v) => v.text)
                .debounceTime(
                    widget.debounce ?? const Duration(milliseconds: 300))
                .where((s) => s.isNotEmpty)
                .distinct()
                .switchMap((s) => _doSearch(s, places)),
          )
          .publishState(const _SearchState(false, null, ''));

  StreamSubscription<void>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _state$.connect();
  }

  Stream<GoogleMapsPlaces> createGoogleMapsPlaces(Map<String, String> headers) {
    assert(() {
      debugPrint('[flutter_google_places_hoc081098] headers=$headers');
      return true;
    }());

    return Rx.using(
      () => GoogleMapsPlaces(
        apiKey: widget.apiKey,
        baseUrl: widget.proxyBaseUrl,
        httpClient: widget.httpClient,
        apiHeaders: <String, String>{
          ...headers,
          ...?widget.headers,
        },
      ),
      (GoogleMapsPlaces places) =>
          Rx.never<GoogleMapsPlaces>().startWith(places),
      (GoogleMapsPlaces places) {
        assert(() {
          debugPrint('[flutter_google_places_hoc081098] disposed');
          return true;
        }());
        return places.dispose();
      },
    );
  }

  Stream<_SearchState> _doSearch(String value, GoogleMapsPlaces places) async* {
    yield _SearchState(true, null, value);

    assert(() {
      debugPrint(
          '''[flutter_google_places_hoc081098] input='$value', location=${widget.location}, origin=${widget.origin}''');
      return true;
    }());

    try {
      final res = await places.autocomplete(
        value,
        offset: widget.offset,
        location: widget.location,
        radius: widget.radius,
        language: widget.language,
        sessionToken: widget.sessionToken,
        types: widget.types ?? const [],
        components: widget.components ?? const [],
        strictbounds: widget.strictbounds ?? false,
        region: widget.region,
        origin: widget.origin,
      );

      if (res.errorMessage?.isNotEmpty == true ||
          res.status == 'REQUEST_DENIED') {
        assert(() {
          debugPrint('[flutter_google_places_hoc081098] REQUEST_DENIED $res');
          return true;
        }());
        onResponseError(res);
      }

      yield _SearchState(
        false,
        PlacesAutocompleteResponse(
          status: res.status,
          errorMessage: res.errorMessage,
          predictions: _sorted(res.predictions),
        ),
        value,
      );
    } catch (e, s) {
      assert(() {
        debugPrint('[flutter_google_places_hoc081098] ERROR $e $s');
        return true;
      }());
      yield _SearchState(false, null, value);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _queryTextController.dispose();

    super.dispose();
  }

  @mustCallSuper
  void onResponseError(PlacesAutocompleteResponse res) {
    if (!mounted) return;
    widget.onError?.call(res);
  }

  @mustCallSuper
  void onResponse(PlacesAutocompleteResponse res) {}

  static List<Prediction> _sorted(List<Prediction> predictions) {
    if (predictions.isEmpty ||
        predictions.every((e) => e.distanceMeters == null)) {
      return predictions;
    }

    final sorted = predictions.sortedBy<num>((e) => e.distanceMeters ?? 0);

    assert(() {
      debugPrint(
          '[flutter_google_places_hoc081098] sorted=${sorted.map((e) => e.distanceMeters).toList(growable: false)}');
      return true;
    }());

    return sorted;
  }
}

class _SearchState {
  final String text;
  final bool isSearching;
  final PlacesAutocompleteResponse? response;

  const _SearchState(this.isSearching, this.response, this.text);

  @override
  String toString() =>
      '_SearchState{text: $text, isSearching: $isSearching, response: $response}';
}

abstract class PlacesAutocomplete {
  PlacesAutocomplete._();

  /// See [PlacesAutocompleteWidget] for more details about the various parameters.
  static Future<Prediction?> show(
      {required BuildContext context,
      required String? apiKey,
      Mode mode = Mode.fullscreen,
      String? hint = 'Search',
      BorderRadius? overlayBorderRadius,
      num? offset,
      Location? location,
      num? radius,
      String? language,
      String? sessionToken,
      List<String>? types,
      List<Component>? components,
      bool? strictbounds,
      String? region,
      Widget? logo,
      ValueChanged<PlacesAutocompleteResponse>? onError,
      String? proxyBaseUrl,
      Client? httpClient,
      String? startText,
      Duration? debounce,
      Location? origin,
      Map<String, String>? headers,
      InputDecoration? textDecoration,
      TextStyle? textStyle,
      Color? cursorColor,
      EdgeInsets? insetPadding,
      Widget? backArrowIcon,
      TextStyle? resultTextStyle}) {
    PlacesAutocompleteWidget builder(BuildContext context) =>
        PlacesAutocompleteWidget(
          apiKey: apiKey,
          mode: mode,
          overlayBorderRadius: overlayBorderRadius,
          language: language,
          sessionToken: sessionToken,
          components: components,
          types: types,
          location: location,
          radius: radius,
          strictbounds: strictbounds,
          region: region,
          offset: offset,
          hint: hint,
          logo: logo,
          onError: onError,
          proxyBaseUrl: proxyBaseUrl,
          httpClient: httpClient,
          startText: startText,
          debounce: debounce,
          origin: origin,
          headers: headers,
          textDecoration: textDecoration,
          textStyle: textStyle,
          cursorColor: cursorColor,
          insetPadding: insetPadding,
          backArrowIcon: backArrowIcon,
          resultTextStyle: resultTextStyle,
        );

    switch (mode) {
      case Mode.overlay:
        return showDialog<Prediction>(context: context, builder: builder);
      case Mode.fullscreen:
        return Navigator.push<Prediction>(
            context, MaterialPageRoute(builder: builder));
    }
  }
}
