import 'package:location/location.dart';
import 'package:mockito/mockito.dart';

class MockLocationData extends Mock implements LocationData {
  final double latitude;
  final double longitude;

  MockLocationData(this.latitude, this.longitude);
}

class MockLocation extends Mock implements Location {
  Future<bool> serviceEnabled() async => true;

  Future<bool> requestService() async => true;

  Future<PermissionStatus> hasPermission() async => PermissionStatus.granted;

  Future<PermissionStatus> requestPermission() async =>
      PermissionStatus.granted;

  Future<LocationData> getLocation() async {
    await Future.delayed(Duration(seconds: 3));
    return MockLocationData(0, 0);
  }
}

