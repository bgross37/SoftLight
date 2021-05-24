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



#define ONE_pin D5
#define TWO_pin D6

SoftLight softlight_one(1);
SoftLight softlight_two(1);
SoftAlarm softalarm_one(1023);
SoftAlarm softalarm_two(1023);
SoftPin one_pin(ONE_pin, 500);
SoftPin two_pin(TWO_pin, 500);


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

  softlight_one.setBrightnessBase100(50);
  softlight_two.setBrightnessBase100(50);
  
  my_homekit_setup();
}

//==============================
// HomeKit setup and loop
//==============================

// access your HomeKit characteristics defined in my_accessory.c

extern "C" homekit_server_config_t accessory_config;

extern "C" homekit_characteristic_t light1_on;
extern "C" homekit_characteristic_t light1_bright;

extern "C" homekit_characteristic_t alarm1_on;

extern "C" homekit_characteristic_t light2_on;
extern "C" homekit_characteristic_t light2_bright;

extern "C" homekit_characteristic_t alarm2_on;


void my_homekit_setup() {
  light1_on.setter = set_on_1;
  light1_bright.setter = set_bright_1;

  alarm1_on.setter = set_alarm_1;

  light2_on.setter = set_on_2;
  light2_bright.setter = set_bright_2;

  alarm2_on.setter = set_alarm_2;

  arduino_homekit_setup(&accessory_config);
}


void set_on_1(const homekit_value_t v) {
 bool on = v.bool_value;
 light1_on.value.bool_value = on; //sync the value

  softlight_one.setOn(on);
}

void set_on_2(const homekit_value_t v) {
  bool on = v.bool_value;
  light2_on.value.bool_value = on; //sync the value

  softlight_two.setOn(on);
}


void set_bright_1(const homekit_value_t v) {
  int bright = v.int_value;
  light1_bright.value.int_value = bright; //sync the value

  softlight_one.setBrightnessBase100(bright);
}

void set_bright_2(const homekit_value_t v) {
  int bright = v.int_value;
  light1_bright.value.int_value = bright; //sync the value

  softlight_two.setBrightnessBase100(bright);
}


void set_alarm_1(const homekit_value_t v) {
  bool on = v.bool_value;
  alarm1_on.value.bool_value = on; //sync the value
  light1_on.value.bool_value = on;
  
  softalarm_one.setOn(on);
  softlight_one.setOn(on);
}

void set_alarm_2(const homekit_value_t v) {
  bool on = v.bool_value;
  alarm2_on.value.bool_value = on; //sync the value
  light2_on.value.bool_value = on;
  
  softalarm_two.setOn(on);
  softlight_two.setOn(on);
}


void loop() {
  arduino_homekit_loop();
  
  if(softalarm_one.getOn()){
    softlight_one.setBrightness(softalarm_one.getBase1023());
    light1_bright.value.int_value = softalarm_one.getBase100();
  }

  if(softalarm_two.getOn()){
    softlight_two.setBrightness(softalarm_two.getBase1023());
    light2_bright.value.int_value = softalarm_two.getBase100();
  }

  softalarm_one.loop();
  softalarm_two.loop();

  softlight_one.compute();
  softlight_two.compute();

  one_pin.set(softlight_one.getW());
  one_pin.loop();

  two_pin.set(softlight_two.getW());
  two_pin.loop();

  // check if wifi is connected
  if(WiFi.status() != WL_CONNECTED){
    WiFi.reconnect();
  }
}
