class IpConfig{
  //static const _URL = "http://10.14.4.159:8080/Room";
  static const _URL = "http://10.14.4.163:8080/Room";
  static const _URL_WS = "ws://10.14.4.163:8080/Room";
  static const _URL_NOPROXY = "http://170.20.10.2:8080/Room";
  String get getURL => _URL;
  String get getURL_WS => _URL_WS;
  String get getURL_NOPROXY => _URL_NOPROXY;
}