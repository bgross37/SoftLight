/*
 *  SoftLight ESP8266
 *  Created on: 2020-10-21
 *      Author: Ben Gross
 */

#include <Arduino.h>
#include <arduino_homekit_server.h>
#include <ESP8266WiFi.h>
#include <SoftPin.h>
#include <SoftAlarm.h>
#include <SoftLight.h>
#include "ClickButton.h"
#include "WifiCredentials.h"



#define LED_pin D6
#define BUTTON_pin D3

ClickButton button1(BUTTON_pin, LOW);
SoftLight softlight(1);
SoftAlarm softalarm(1023);
SoftPin w_pin(LED_pin, 500);


void setup() {
  Serial.begin(115200);
  Serial.println("Starting the programm...");
 

  WiFi.persistent(false);
  WiFi.mode(WIFI_STA);
  WiFi.setAutoReconnect(true);
  WiFi.setSleepMode(WIFI_NONE_SLEEP);
  WiFi.begin(ssid, password);
  Serial.println("WiFi connecting...");
  while (!WiFi.isConnected()) {
    delay(100);
    Serial.print(".");
  }
  Serial.print("\n");
  Serial.printf("WiFi connected, IP: %s\n", WiFi.localIP().toString().c_str());

  softlight.setBrightnessBase100(50);
  
  my_homekit_setup();
}

//==============================
// HomeKit setup and loop
//==============================

// access your HomeKit characteristics defined in my_accessory.c

extern "C" homekit_server_config_t accessory_config;

extern "C" homekit_characteristic_t light_on;
extern "C" homekit_characteristic_t light_bright;

extern "C" homekit_characteristic_t alarm_on;

extern "C" homekit_characteristic_t cha_programmable_switch_event;

homekit_value_t cha_programmable_switch_up_event_getter() {
  // Should always return "null" for reading, see HAP section 9.75
  return HOMEKIT_NULL_CPP();
}

void my_homekit_setup() {
  light_on.setter = set_on;
  light_bright.setter = set_bright;

  alarm_on.setter = set_alarm;

  arduino_homekit_setup(&accessory_config);
}


void set_on(const homekit_value_t v) {
  bool on = v.bool_value;
  light_on.value.bool_value = on; //sync the value

  softlight.setOn(on);
}


void set_bright(const homekit_value_t v) {
  int bright = v.int_value;
  light_bright.value.int_value = bright; //sync the value

  softlight.setBrightnessBase100(bright);
}


void set_alarm(const homekit_value_t v){
  bool on = v.bool_value;
  alarm_on.value.bool_value = on; //sync the value
  light_on.value.bool_value = on;
  
  softalarm.setOn(on);
  softlight.setOn(on);
}


void loop() {
  arduino_homekit_loop();
  
  if(softalarm.getOn()){
    softlight.setBrightness(softalarm.getBase1023());
    light_bright.value.int_value = softalarm.getBase100();
  }

  button1.Update();
  
  if (button1.clicks != 0){
    uint8_t cha_value = 0;
    switch(button1.clicks){
      case 1: 
        cha_value = 0;
        break;
      case 2:
        cha_value = 1;
        break;
      case -1:
        cha_value = 2;
        break;
      default:
        cha_value = 0;
    }
    cha_programmable_switch_event.value.uint8_value = cha_value;
    homekit_characteristic_notify(&cha_programmable_switch_event, cha_programmable_switch_event.value);
  }

  softlight.compute();

  softalarm.loop();

  w_pin.set(softlight.getW());
  w_pin.loop();

  // check if wifi is connected
  if(WiFi.status() != WL_CONNECTED){
    WiFi.reconnect();
  }
}
