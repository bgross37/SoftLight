/*
  SoftAlarm.h - Library for a slow rise in value over time.
  Created by Ben Gross, 05-20-2021.
  Released into the public domain.
*/

#ifndef SOFT_ALARM
#define SOFT_ALARM
#include <Arduino.h>
class SoftAlarm {
  
  private:
    long _millisAtStart;
    bool _state;
    int _maxBrightness;
    int _value;
    void setValue(int _v);
    
  public:
    SoftAlarm(int maxBrightness);
    void setOn(bool on);
    void loop();
    bool getOn();
    int getBase100();
    int getBase1023();
};
#endif