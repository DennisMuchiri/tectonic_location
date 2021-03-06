import 'package:flutter/material.dart';
import 'package:tectonic_location/tectonic_location.dart';

class ServiceEnabledWidget extends StatefulWidget {
  const ServiceEnabledWidget({Key key}) : super(key: key);

  @override
  _ServiceEnabledState createState() => _ServiceEnabledState();
}

class _ServiceEnabledState extends State<ServiceEnabledWidget> {
  final Location location = Location();

  bool _serviceEnabled;

  Future<void> _checkService() async {
    final bool serviceEnabledResult = await location.serviceEnabled();
    setState(() {
      _serviceEnabled = serviceEnabledResult;
    });
  }

  Future<void> _requestService() async {
    if (_serviceEnabled == null || !_serviceEnabled) {
      final bool serviceRequestedResult = await location.requestService();
      setState(() {
        _serviceEnabled = serviceRequestedResult;
      });
      if (!serviceRequestedResult) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Service enabled: ${_serviceEnabled ?? "unknown"}',
            style: Theme.of(context).textTheme.body2),
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 42),
              child: RaisedButton(
                child: const Text('Check'),
                onPressed: _checkService,
              ),
            ),
            RaisedButton(
              child: const Text('Request'),
              onPressed: _serviceEnabled == true ? null : _requestService,
            )
          ],
        )
      ],
    );
  }
}
