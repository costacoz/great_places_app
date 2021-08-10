import 'dart:convert';
import 'package:http/http.dart' as http;

/// G-Map functionality not implemented as the API key is missing.

const GOOGLE_KEY_API = '...api key...';

class LocationHelper {
  static String generateLocationPreviewImage({double latitude = 0.0, double longitude = 0.0}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=AIzaSyA3kg7YWugGl1lTXmAmaBGPNhDW9pEh5bo&signature=GJnbP6sQrFY1ce8IsvG2WR2P0Jw=';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    // final url = Uri(
    //   host: 'maps.googleapis.com',
    //   scheme: 'https',
    //   query:
    //       '5m2&1d57&2d24&7sUS&9sen-US&callback=_xdc_._ss83q2&key=AIzaSyB41DRUbKWJHPxaFjMAwdrzWzbVKartNGg&channel=1&token=9184',
    //   path: '/maps/api/js/GeocodeService.Search',
    // );
    // final response = await http.get(url);
    // print(response);

    return "11. novembra krastmala 9, Centra rajons, Rīga, LV-1050, Latvia";
  }
}
