import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class HttpsConnect {
  Future<IOClient> https() async {
    final HttpClient httpClient = await createHttpClientWithCustomValidation();
    final IOClient ioClients = IOClient(httpClient);
    return ioClients;
  }

  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('assets/isrgrootx1.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  Future<HttpClient> createHttpClientWithCustomValidation() async {
    return HttpClient(context: await globalContext)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return validateCertificate(cert, host);
      }
      ..connectionTimeout = const Duration(seconds: 20);
  }

  // Example certificate validation function
  bool validateCertificate(X509Certificate cert, String host) {
    if (!cert.issuer.contains('TrustedIssuer')) {
      print('Certificate issuer is not trusted');
      return false;
    }
    // Check certificate validity period
    var now = DateTime.now();
    if (now.isBefore(cert.startValidity) || now.isAfter(cert.endValidity)) {
      print('Certificate is expired or not yet valid');
      return false;
    }
    return true;
  }
}
