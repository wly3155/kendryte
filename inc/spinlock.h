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

#ifndef __SPINLOCK_H__
#define __SPINLOCK_H__

#include <stdint.h>

#ifdef cplusplus
extern "c"
{
#endif

        typedef struct
        {
                int counter;
        } atomic_t;

#define ATOMIC_INIT(x)              \
        do                          \
        {                           \
                atomic_t *tmp = x;  \
                (tmp)->counter = 0; \
        } while (0);

#ifndef atomic_set
#define atomic_set(ptr, val) (*(volatile typeof(*(ptr)) *)(ptr) = val)
#endif

#ifndef atomic_read
#define atomic_read(ptr) (*(volatile typeof(*(ptr)) *)(ptr))
#endif

        int32_t atomic_fetch_and_add(atomic_t *ptr, int32_t val);

#ifdef cplusplus
}
#endif

#endif