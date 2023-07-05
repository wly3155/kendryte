/* Copyright 2018 Canaan Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include <stdio.h>
#include <FreeRTOS.h>
#include <task.h>

#include "syslog.h"
#include "inc/spinlock.h"

static atomic_t test;

int main()
{
    static uint8_t count = 0;

    ATOMIC_INIT(&test);

    while (1) {
        atomic_fetch_and_add(&test, 2);
        printf("Hello World %u, %d\n", count, atomic_read(&test));
        count++;
        vTaskDelay(100);
    }
}
