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

#ifndef __UTILS_H__
#define __UTILS_H__

#include <stdint.h>
#include <sys/time.h>

#ifdef __cplusplus
extern "c"
{
#endif

#define REG32_READ(reg) (*((volatile uint32_t *)reg))
#define REG32_WRITE(reg, value) (*((volatile uint32_t *)reg) = value)

#define min(x, y) ((x) < (y) ? (x) : (y))

#define ms_to_ns(time) ((uint64_t)(time)*1000000)

#ifdef __cplusplus
}
#endif
#endif
