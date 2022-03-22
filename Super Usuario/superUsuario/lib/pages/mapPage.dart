import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prowess_app/models/pedidoModel.dart';
import 'package:prowess_app/pages/detailsPage.dart';
import 'package:location/location.dart';
import 'package:prowess_app/services/directions_model.dart';
import 'package:prowess_app/services/directions_repository.dart';
import 'package:prowess_app/services/ordersMoto.dart';
import 'dart:math' show cos, sqrt, asin;

class mapPage extends StatefulWidget {
  const mapPage({Key? key, required this.pedido}) : super(key: key);
  final Pedido pedido;
  @override
  State<mapPage> createState() => _MapPageState();
}

class _MapPageState extends State<mapPage> {
  // ignore: unused_field
  OrdersMoto _service = OrdersMoto();

  Set<Marker> _markers = Set<Marker>();

  Completer<GoogleMapController> _controller = Completer();
  //GoogleMapController _googleMapController;
  Marker _motorized = new Marker(markerId: MarkerId('motorizado'));
  Marker _buyer = new Marker(markerId: MarkerId('comprador'));
  Marker _seller = new Marker(markerId: MarkerId('vendedor'));

  PolylinePoints polylinePoints = new PolylinePoints();
  List<PointLatLng> polPoints = [];
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  Directions _info = Directions(
      bounds: LatLngBounds(northeast: LatLng(0, 0), southwest: LatLng(0, 0)),
      polylinePoints: PolylinePoints().decodePolyline(""),
      totalDistance: '5',
      totalDuration: '0');

  // static final CameraPosition _initialCamperaPosition = CameraPosition(
  //   target: LatLng(-0.9335863141754581, -78.61500222658208),
  //   zoom: 18.5,
  // );

  //PERMISOS LOCACION
  Location location = Location();
  bool? _serviceEnabled;
  bool _isGetLocation = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    print("inicio del Estado");
    requestCurrentUbi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        _isGetLocation
            ? GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: new CameraPosition(
                  target: LatLng(
                      _locationData!.latitude!, _locationData!.longitude!),
                  zoom: 18.5,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);

                  var motorizado = LatLng(
                      _locationData!.latitude!, _locationData!.longitude!);
                  var vendedor = LatLng(
                      double.parse(widget.pedido.vendedor!.lat ?? ""),
                      double.parse(widget.pedido.vendedor!.long ?? ""));
                  var comprador = LatLng(
                      double.parse(widget.pedido.comprador!.lat ?? ""),
                      double.parse(widget.pedido.comprador!.long ?? ""));

                  _addMarkers(motorizado, vendedor, comprador);
                },
                //markers: _markers,
                markers: {
                    this._motorized,
                    this._buyer,
                    this._seller,
                  },
                polylines: {
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Colors.red,
                      width: 5,
                      points: this
                          ._info
                          .polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    )
                  })
            : CircularProgressIndicator(),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            margin: EdgeInsets.all(5),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 15,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(
                              pedidos: widget.pedido,
                            )));
              },
              child: Icon(Icons.list),
            ),
          ),
        ),
        Positioned(
          top: 20.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                )
              ],
            ),
            child: Text(
              '${this._info.totalDistance}, ${this._info.totalDuration}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Future<void> _addMarkers(
      LatLng motorized, LatLng seller, LatLng buyer) async {
    await _controller.future;
    setState(() {
      this._motorized = Marker(
        markerId: const MarkerId("Motorizado"),
        infoWindow: const InfoWindow(title: 'Motorizado'),
        position: motorized,
      );

      _info;

      this._seller = Marker(
        markerId: const MarkerId("Vendedor"),
        infoWindow: const InfoWindow(title: 'Vendedor'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: seller,
      );

      this._buyer = Marker(
        markerId: const MarkerId("Comprador"),
        infoWindow: const InfoWindow(title: 'Comprador'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        position: buyer,
      );
    });

    final directions = await DirectionsRepository().getDirections(
        origin: _motorized.position, destination: _seller.position);
    setState(() => this._info = directions!);
  }

  /*Future<void> _goToNewYork() async {
    await _controller.future;
    _cities.forEach((element) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(element.nombre.toString()),
            infoWindow: InfoWindow(title: element.provincia),
            position: LatLng(
                element.latitud!.toDouble(), element.longitud!.toDouble()),
          ),
        );
      });
    });
  }*/

  /*_loadCities() {
    _cityService.getCities().then((value) {
      print(value.toString());
      _cities = value;
      setState(() {});
    });
  }*/
  /*  _loadData() {
    _service.getPackages(_service.getUID()).then((value) {
      _packages = value[0];
      package = _packages;
      if (mounted) {
        setState(() {});
      }
    });
  }*/

  requestCurrentUbi() async {
    //PREGUNTO SI EL SERVICIO ESTA DISPONIBLE
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled!) return;
    }

    //PREGUNTO SI SE TIENE PERMISOS PARA ACCEDER A LA UBICACION
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    //AQUI OBTENGO MI DIRECCION ACTUAL SI CONCEDI LOS PERMISOS AL DISPOSITIVO
    _locationData = await location.getLocation();
    setState(() {
      _isGetLocation = true;
      _markers.add(Marker(
        markerId: MarkerId('Ubicacion Motorizado'),
        position: LatLng(_locationData!.latitude!, _locationData!.longitude!),
      ));
    });
  }
}
