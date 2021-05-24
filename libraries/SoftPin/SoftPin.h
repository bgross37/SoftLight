/*
  SoftPin.h - Library for smooth transitions between pin output values.
  Created by Ben Gross, 10-27-2020.
  Released into the public domain.
*/
#ifndef SoftPin_h
#define SoftPin_h

#include "Arduino.h"

class SoftPin
{
  public:
    SoftPin(int pin, int smoothTime);
    void set(int value);
    void set255(int value);
    void set100(int value);
    void loop();
    int getCurrentValue();
    int getTargetValue();
    int getLastValue();
  private:
    int _pin;
    int _last_V;
    int _current_V;
    int _target_V;
    long _millis_at_change;
    int _smoothTime;
};

#endif