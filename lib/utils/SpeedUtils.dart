
import 'dart:ffi';

class SpeedUtils{

  static String getSpeedString(int level){
    String speedString = "1x";
    switch(level) {
      case 1:
        speedString = "0.25x";
        break;
      case 2:
        speedString = "0.5x";
        break;
      case 3:
        speedString = "1x";
        break;
      case 4:
        speedString = "1.25x";
        break;
      case 5:
        speedString = "1.5x";
        break;
      case 6:
        speedString = "2x";
        break;
      case 7:
        speedString = "5x";
        break;
    }
    return speedString;
  }

  static double getSpeed(int level){
    double speed = 1.0;
    switch(level) {
      case 1:
        speed = 0.25;
        break;
      case 2:
        speed = 0.5;
        break;
      case 3:
        speed = 1.0;
        break;
      case 4:
        speed = 1.25;
        break;
      case 5:
        speed = 1.5;
        break;
      case 6:
        speed = 2.0;
        break;
      case 7:
        speed = 5.0;
        break;
    }
    return speed;
  }

}