/*
  SoftAlarm.cpp - Library for a slow rise in value over time.
  Created by Ben Gross, 05-20-2021.
  Released into the public domain.
*/

#include "SoftAlarm.h"

long _millisAtStart = 0;
boolean _state = false;
int _maxBrightness = 1023;
int _value = 0;

SoftAlarm::SoftAlarm(int maxBrightness){
  _state = false;
  _maxBrightness = maxBrightness;
}

void SoftAlarm::setOn(bool on){
  _state = on;
  _value = 0;
  _millisAtStart = millis();
}

void SoftAlarm::loop(){
  if(_state){
    float _dutyCycle = pow( (float)(millis() - _millisAtStart), 2) * 0.00000004;

    if(_dutyCycle > _maxBrightness){
      _dutyCycle = _maxBrightness;
    }

    setValue(_dutyCycle);
  }
  else {
    setValue(0);
  }
}

bool SoftAlarm::getOn(){
  return _state;
}

int SoftAlarm::getBase100(){
  return map(_value, 0, 1023, 0, 100);
}

int SoftAlarm::getBase1023(){
  return _value;
}

void SoftAlarm::setValue(int _v){
  _v < 0 ? _v = 0 : _v;
  _v > 1023 ? _v = 1023 : _v;
  _value = _v;
}
