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
#include <bsp.h>
#include <sysctl.h>
#include <FreeRTOS.h>
#include <task.h>

static void vTaskCode(void * pvParameters)
{
    static uint8_t count = 0;

    while (1) {
        printf("Core %ld Hello world %u\n", current_coreid(), count);
        count++;
        vTaskDelay(1000);
    }
}

int core1_function(void *ctx)
{
    BaseType_t ret = pdFALSE;
    uint64_t core = current_coreid();

    printf("Core %ld Hello world\n", core);
    ret = xTaskCreate(vTaskCode, "CORE1", configMAIN_TASK_STACK_SIZE, NULL, 2, NULL);
    if (ret != pdPASS)
        printf("core1 create task fail\n");

    printf("core1 create task sucess\n");
    vTaskStartScheduler();
    while(1);
}

int main(void)
{
    //sysctl_pll_set_freq(SYSCTL_PLL0, 800000000);
    uint64_t core = current_coreid();
    int data = 0;
    uint64_t *tmp = (uint64_t *)80;

    printf("Core %ld Hello world\n", core);
    //register_core1(core1_function, NULL);

    /* Clear stdin buffer before scanf */
    //sys_stdin_flush();

    //scanf("%d", &data);
    printf("Data is %d 0x%lx\n", data, *tmp);
    printf("Data is %d 0x%lx\n", data, *tmp);        
    static uint8_t count = 0;
    printf("Core %ld Hello world %u\n", current_coreid(), count);
    while (1) {
        printf("Core %ld Hello world %u\n", current_coreid(), count);
        count++;
        //vTaskDelay(100);
    }
    return 0;
}

void vApplicationIdleHook(void)
{
    printf("idle\n");
    while (1);
}