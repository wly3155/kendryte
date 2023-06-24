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
#ifndef _BSP_SLEEP_H
#define _BSP_SLEEP_H

#include <clint.h>
#include <encoding.h>
#include <sys/time.h>

extern int nanosleep(const struct timespec* req, struct timespec* rem);
extern int usleep(useconds_t usec);
extern unsigned int sleep(unsigned int seconds);

#endif /* _BSP_SLEEP_H */
