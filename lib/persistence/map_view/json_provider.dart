import 'dart:convert';

import 'package:gc_wizard/persistence/map_view/model.dart';
import 'package:gc_wizard/persistence/utils.dart';
import 'package:prefs/prefs.dart';

void refreshMapViews() {
  var rawMapViews = Prefs.getStringList('mapview_mapviews');
  if (rawMapViews == null || rawMapViews.length == 0)
    return;

  mapViews = rawMapViews
    .where((view) => view.length > 0)
    .map((view) {
      return MapViewDAO.fromJson(jsonDecode(view));
    })
    .toList();
}

_saveData() {
  var jsonData = mapViews
    .map((view) => jsonEncode(view.toMap()))
    .toList();

  Prefs.setStringList('mapview_mapviews', jsonData);
}

int insertMapViewDAO(MapViewDAO view) {
  view.name = view.name ?? '';
  var id = newID(
    mapViews
      .map((view) => view.id)
      .toList()
  );
  view.id = id;
  mapViews.add(view);

  _saveData();

  return id;
}

void updateMapViews() {
  _saveData();
}

void deleteMapViewDAO(int viewId) {
  mapViews.removeWhere((group) => group.id == viewId);

  _saveData();
}

void _updateMapView(MapViewDAO view) {
  mapViews = mapViews.map((mapView) {
    if (mapView.id == view.id)
      return view;

    return mapView;
  }).toList();
}

void insertMapPointDAO(MapPointDAO point, MapViewDAO mapView) {
  mapView.points.add(point);

  _updateMapView(mapView);
  _saveData();
}

void updateMapPointDAO(MapPointDAO point, MapViewDAO mapView) {
  mapView.points = mapView.points.map((mapPoint) {
    if (mapPoint.uuid == point.uuid)
      return point;

    return mapPoint;
  }).toList();

  _updateMapView(mapView);
  _saveData();
}

void deleteMapPointDAO(String pointUUID, MapViewDAO mapView) {
  mapView.points.removeWhere((point) => point.uuid == pointUUID);

  _updateMapView(mapView);
  _saveData();
}

void insertMapPolylineDAO(MapPolylineDAO polyline, MapViewDAO mapView) {
  mapView.polylines.add(polyline);

  _updateMapView(mapView);
  _saveData();
}

void updateMapPolylineDAO(MapPolylineDAO polyline, MapViewDAO mapView) {
  mapView.polylines = mapView.polylines.map((mapPolyline) {
    if (mapPolyline.uuid == polyline.uuid)
      return polyline;

    return mapPolyline;
  }).toList();

  _updateMapView(mapView);
  _saveData();
}

void deleteMapPolylineDAO(String polylineUUID, MapViewDAO mapView) {
  mapView.polylines.removeWhere((polyline) => polyline.uuid == polylineUUID);

  _updateMapView(mapView);
  _saveData();
}