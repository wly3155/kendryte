
/*
 * This file is licensed under the Apache License, Version 2.0.
 *
 * Copyright (c) 2023 wuliyong3155@163.com
 *
 * A copy of the license can be obtained at: http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <stdarg.h>
#include "FreeRTOS.h"
#include "task.h"
#include "printf.h"
#include "uarths.h"
#include "inc/time.h"

#define LOG_BUF_SIZE			256

static char log_buf[LOG_BUF_SIZE] = {'\0'};

static void log_header_format()
{
	uint64_t now = get_boot_time_ns();
	uint32_t sec = now / 1000000000;
	uint32_t mini_sec = now % 1000000000 / 1000000;
	snprintf(log_buf, sizeof(log_buf), "[%u.%03u] ", sec, mini_sec);
}

static void usart_printf(char *ptr, uint8_t len)
{
#ifdef CFG_USART_SUPPORT
    uint8_t i = 0;
    for (i = 0; i < len; i++)
        uarths_write_byte(ptr[i]);
#endif
}

static void uart_putf(void* unused, char c)
{
    //UNUSED(unused);
    uarths_write_byte(c);
}

int __wrap_printf(const char *fmt, ...)
{
	uint8_t log_buf_used = 0;
	char *log_buf_to_write = NULL;
	va_list args;
	log_header_format();
	log_buf_used = strlen(log_buf);
	log_buf_to_write = log_buf + log_buf_used;
	va_start(args, fmt);
	vsnprintf(log_buf_to_write, LOG_BUF_SIZE - log_buf_used, fmt, args);
	//usart_printf(log_buf, strlen(log_buf));
    tfp_format(NULL, uart_putf, fmt, args);
	va_end(args);
	return 0;
}
int log_init()
{
#ifdef CFG_USART_SUPPORT
	//usart_init(USART_TX_PIN, USART_RX_PIN);
#endif
	return 0;
}
