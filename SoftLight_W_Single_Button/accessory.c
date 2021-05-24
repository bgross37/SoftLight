/*
 * my_accessory.c
 * Define the accessory in C language using the Macro in characteristics.h
 *
 *  Created on: 2020-10-21
 *      Author: Ben Gross
 */

#include <homekit/homekit.h>
#include <homekit/characteristics.h>

void my_accessory_identify(homekit_value_t _value) {
	printf("accessory identify\n");
}

homekit_characteristic_t light_on = HOMEKIT_CHARACTERISTIC_(ON, false);
homekit_characteristic_t light_name = HOMEKIT_CHARACTERISTIC_(NAME, "SoftLight Light");
homekit_characteristic_t light_bright = HOMEKIT_CHARACTERISTIC_(BRIGHTNESS, 50);


homekit_characteristic_t alarm_on = HOMEKIT_CHARACTERISTIC_(ON, false);
homekit_characteristic_t alarm_name = HOMEKIT_CHARACTERISTIC_(NAME, "SoftLight Alarm");

homekit_characteristic_t cha_programmable_switch_event = HOMEKIT_CHARACTERISTIC_(PROGRAMMABLE_SWITCH_EVENT, 0);
homekit_characteristic_t button_name = HOMEKIT_CHARACTERISTIC_(NAME, "SoftLight Button");

homekit_accessory_t *accessories[] = {
    HOMEKIT_ACCESSORY(.id=1, .category=homekit_accessory_category_lightbulb, .services=(homekit_service_t*[]) {
        HOMEKIT_SERVICE(ACCESSORY_INFORMATION, .characteristics=(homekit_characteristic_t*[]) {
            HOMEKIT_CHARACTERISTIC(NAME, "SoftLight"),
            HOMEKIT_CHARACTERISTIC(MANUFACTURER, "Ben"),
            HOMEKIT_CHARACTERISTIC(SERIAL_NUMBER, "0123457"),
            HOMEKIT_CHARACTERISTIC(MODEL, "ESP8266"),
            HOMEKIT_CHARACTERISTIC(FIRMWARE_REVISION, "1.0"),
            HOMEKIT_CHARACTERISTIC(IDENTIFY, my_accessory_identify),
            NULL
        }),
        HOMEKIT_SERVICE(LIGHTBULB, .primary=true, .characteristics=(homekit_characteristic_t*[]) {
            &light_on,
            &light_name,
            &light_bright,
            NULL
        }),
        HOMEKIT_SERVICE(LIGHTBULB, .primary=false, .characteristics=(homekit_characteristic_t*[]) {
            &alarm_on,
            &alarm_name,
            NULL
        }),
        HOMEKIT_SERVICE(STATELESS_PROGRAMMABLE_SWITCH, .primary=false, .characteristics=(homekit_characteristic_t*[]) {
            &cha_programmable_switch_event,
            &button_name,
            NULL
        }),
        NULL
    }),
    NULL
};

homekit_server_config_t accessory_config = {
    .accessories = accessories,
    .password = "111-11-111"
};
