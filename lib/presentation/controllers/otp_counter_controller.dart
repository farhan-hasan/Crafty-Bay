import 'dart:developer';
import 'package:get/get.dart';

class OtpCounterController extends GetxController {

  RxInt _counter = 10.obs;
  bool _isTimeUp = false;

  RxInt get counter => _counter;
  bool get isTimeUp => _isTimeUp;

  void decrementCounter() {
    //log("Counting");
    _counter--;
    if(_counter<=0){
      _isTimeUp = true;
    }
    update();
  }
  void resetCounter() {
    _isTimeUp = false;
    _counter = 10.obs;
    //update();
  }


}