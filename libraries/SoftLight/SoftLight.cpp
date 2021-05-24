/*
  SoftLight.cpp - Library for managing a light.
  Created by Ben Gross, 05-20-2021.
  Released into the public domain.
*/

#include "SoftLight.h"

bool _on = false;
int _brightness = 0;        //0-1023
int _hue = 0;               //0-256
int _saturation = 0;        //0-100
int _temperature = 0;       //0-100

int _w = 0;
int _ww = 0;
int _r = 0;
int _g = 0;
int _b = 0;

SoftLight::SoftLight(int type){
    type = 1;
}

void SoftLight::setOn(bool on){
    _on = on;
}

void SoftLight::setBrightness(int brightness){
    brightness = brightness > 1023 ? 1023 : brightness;
    brightness = brightness < 0 ? 0 : brightness;
    _brightness = brightness;
}

void SoftLight::setBrightnessBase100(int brightness){
    brightness = brightness > 100 ? 100 : brightness;
    brightness = brightness < 0 ? 0 : brightness;
    _brightness = map(brightness, 0, 100, 0, 1023);
}

void SoftLight::setHue(int hue){
    hue = hue > 256 ? 256 : hue;
    hue = hue < 0 ? 0 : hue;
    _hue = hue;
}

void SoftLight::setSaturation(int saturation){
    saturation = saturation > 100 ? 100 : saturation;
    saturation = saturation < 0 ? 0 : saturation;
    _saturation = saturation;
}

void SoftLight::setTemperature(int temperature){
    temperature = temperature > 100 ? 100 : temperature;
    temperature = temperature < 0 ? 0 : temperature;
    _temperature = temperature;
}

bool SoftLight::getOn(){
    return _on;
}

void SoftLight::compute(){
    //lots of computation here in the future
    if(!_on){
        _w = 0;
        _ww = 0;
        _r = 0;
        _g = 0;
        _b = 0;
    }
    else{
        _w = _brightness;
    }
}

int SoftLight::getBrightness(){
    return _brightness;
}

int SoftLight::getBrightnessBase100(){
   return map(_brightness, 0, 1023, 0, 100); 
}

int SoftLight::getHue(){
    return _hue;
}

int SoftLight::getSaturation(){
    return _saturation;
}

int SoftLight::getTemperature(){
    return _temperature;
}

int SoftLight::getW(){
    return _w;
}

int SoftLight::getWW(){
    return _ww;
}

int SoftLight::getR(){
    return _r;
}

int SoftLight::getG(){
    return _g;
}

int SoftLight::getB(){
    return _b;
}