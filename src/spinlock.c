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

#include <stdbool.h>
#include "inc/spinlock.h"

int32_t atomic_fetch_and_add(volatile atomic_t *ptr, int32_t a)
{
	int prev = 0, rc;

	__asm volatile (
		"0:	lr.w     %[p],  %[c]\n"
		"	add      %[rc], %[p], %[a]\n"
		"	sc.w.rl  %[rc], %[rc], %[c]\n"
		"	bnez     %[rc], 0b\n"
		"	fence    rw, rw\n"
		"1:\n"
		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (ptr->counter)
		: [a]"r" (a)
		: "memory"
	);

	return prev;
}

int32_t atomic_add(atomic_t *ptr, int32_t val)
{
	int curr_val = 0;
	bool store_fail = false;

	do {
		__asm volatile (
			"lr.w %1, (%2)\n"
			"add %1, %1, %3\n"
			"sc.w %0, %1, (%2)\n"
			: "+&r"(store_fail), "=&r"(curr_val)
			: "r"(ptr), "r"(val)
			: "memory"
		);
	} while (store_fail);

	return curr_val;
}

bool atomic_cmpxchg(atomic_t *ptr, int32_t old, int32_t new)
{
	bool ret = false;
	int32_t curr_val = 0;

	do {
		__asm volatile {
			"lr.w %1, (%2)\n"
			"beq %1 %3 1f\n"
			"sc.w %0, %4 (%2)"
			: "+&r"(store_fail), "=&r"(curr_val)
			: "r"(ptr), "r"(old), "r"(new)
			: "memory"

		1:
			return false;
		}
	}
}

bool raw_spinlock_try_lock(spinlock_t *lock)
{
	uint32_t old = atomic_read(lock);

	if ((old >> 16) != (old & 0xffff))
		return false;

	return atomic_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
}

void raw_spinlock_lock(spinlock_t *lock)
{
	uint32_t val = atomic_fetch_add_add(lock, 1<<16);
	uint16_t ticket = val >> 16;

	if (ticket == (uint16_t)val)
		return true;
}

void spinlock_lock(spinlock_t *lock)
{
	do {
		while (atomic_read(&lock));
	} while (raw_spinlock_try_lock(&lock));
}