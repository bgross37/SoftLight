/*
  SoftLight.h - Library for managing a light.
  Created by Ben Gross, 05-20-2021.
  Released into the public domain.
*/

#ifndef SOFT_LIGHT
#define SOFT_LIGHT
#include <Arduino.h>

#define SOFTLIGHT_TYPE_W    1;

class SoftLight {
    public:
        SoftLight(int type);
        void setOn(bool on);
        void setBrightness(int brightness);
        void setBrightnessBase100(int brightness);
        void setHue(int hue);
        void setSaturation(int saturation);
        void setTemperature(int temperature);
        bool getOn();
        int getBrightness();
        int getBrightnessBase100();
        int getHue();
        int getSaturation();
        int getTemperature();
        void compute();
        int getW();
        int getWW();
        int getR();
        int getG();
        int getB();
    private:
        bool _on;
        int _brightness;        //0-1023
        int _hue;               //0-256
        int _saturation;        //0-100
        int _temperature;
        int _w;
        int _ww;
        int _r;
        int _g;
        int _b;
};
#endif