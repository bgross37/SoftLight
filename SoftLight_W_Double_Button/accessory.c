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

homekit_characteristic_t light1_on = HOMEKIT_CHARACTERISTIC_(ON, false);
homekit_characteristic_t light1_name = HOMEKIT_CHARACTERISTIC_(NAME, "Light 1");
homekit_characteristic_t light1_bright = HOMEKIT_CHARACTERISTIC_(BRIGHTNESS, 50);

homekit_characteristic_t light2_on = HOMEKIT_CHARACTERISTIC_(ON, false);
homekit_characteristic_t light2_name = HOMEKIT_CHARACTERISTIC_(NAME, "Light 2");
homekit_characteristic_t light2_bright = HOMEKIT_CHARACTERISTIC_(BRIGHTNESS, 50);


homekit_characteristic_t alarm1_on = HOMEKIT_CHARACTERISTIC_(ON, false);
homekit_characteristic_t alarm1_name = HOMEKIT_CHARACTERISTIC_(NAME, "Alarm 1");

homekit_characteristic_t alarm2_on = HOMEKIT_CHARACTERISTIC_(ON, false);
homekit_characteristic_t alarm2_name = HOMEKIT_CHARACTERISTIC_(NAME, "Alarm 2");

homekit_accessory_t *accessories[] = {
    HOMEKIT_ACCESSORY(.id=1, .category=homekit_accessory_category_lightbulb, .services=(homekit_service_t*[]) {
        HOMEKIT_SERVICE(ACCESSORY_INFORMATION, .characteristics=(homekit_characteristic_t*[]) {
            HOMEKIT_CHARACTERISTIC(NAME, "DoubleLight"),
            HOMEKIT_CHARACTERISTIC(MANUFACTURER, "Ben"),
            HOMEKIT_CHARACTERISTIC(SERIAL_NUMBER, "0123457"),
            HOMEKIT_CHARACTERISTIC(MODEL, "ESP8266"),
            HOMEKIT_CHARACTERISTIC(FIRMWARE_REVISION, "1.0"),
            HOMEKIT_CHARACTERISTIC(IDENTIFY, my_accessory_identify),
            NULL
        }),
        HOMEKIT_SERVICE(LIGHTBULB, .primary=true, .characteristics=(homekit_characteristic_t*[]) {
            &light1_on,
            &light1_name,
            &light1_bright,
            NULL
        }),
        HOMEKIT_SERVICE(LIGHTBULB, .primary=false, .characteristics=(homekit_characteristic_t*[]) {
            &light2_on,
            &light2_name,
            &light2_bright,
            NULL
        }),
        HOMEKIT_SERVICE(LIGHTBULB, .primary=false, .characteristics=(homekit_characteristic_t*[]) {
            &alarm1_on,
            &alarm1_name,
            NULL
        }),
        HOMEKIT_SERVICE(LIGHTBULB, .primary=false, .characteristics=(homekit_characteristic_t*[]) {
            &alarm2_on,
            &alarm2_name,
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
