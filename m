Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2007 21:28:14 +0000 (GMT)
Received: from mail.zeugmasystems.com ([70.79.96.174]:59305 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20034818AbXKSV2G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2007 21:28:06 +0000
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: futex_wake_op deadlock?
Date:	Mon, 19 Nov 2007 13:27:37 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C54DCDE2@exchange.ZeugmaSystems.local>
In-Reply-To: <20071119184837.GA12287@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: futex_wake_op deadlock?
Thread-Index: Acgq3M3SscB26V6iT9WqOzIqyKCfJAAFKJyA
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Nov 16, 2007 at 03:52:47PM -0800, Kaz Kylheku wrote:
> 
>> From time to time, on 2.6.17.7, I see a deadlock situation go off.
>> The soft lockup tick occurs in the middle of do_futex, which is
>> heavily inlined.  The system is actually hosed; it's not one of those
>> recoverable CPU busy situations that can sometimes trigger the lockup
>> detector.
> 
> Can you reproduce thing hang also if you're not running in a
> binary compat
> mode, that is either running o32 binaries on a 32-bit kernel or
> 64-bit binaries on a 64-bit kernel? 

I have hacked up little a test program which hosed my board within
seconds.
The system is not completely hung. However:

- I can't kill the test program with Ctrl-C.
- I can log into the box with telnet.
- If I run "ps aux" to see all processes, the ps command hangs partway
through the table, and cannot be killed with Ctrl-C.
- System hangs on soft reboot attempt; requires hard reset.

The program basically uses several threads to beat up the FUTEX_WAKE_OP.

The key trick is that there is an interfering thread which does a
mmap/munmap on the futexes in parallel with the threads which are using
them. .

If I just stick the futexes into a permanently good memory location,
nothing bad happens; the program just churns away taking up 400% of the
CPU time across the four cores of the 1480. If you call the function
with permanently bad addresses, nothing bad happens either; the syscalls
bail nicely with EFAULT.

The idea is to tickle some race condition or other bug in the
interaction between futexes and mmap.  I put a little delay into the
interfering thread so that the memory is held in a good state most of
the time, with a quick unmap/remap. We want the memory to be good most
of the time, but an unmap to happen from time to time at an inopportune
time, while the kernel is executing the futex code on one or more cores

This needs to be compiled -pthread, obviously, and you need -lrt to link
in the library for clock_nanosleep.

#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>
#include <sys/syscall.h>
#include <sys/mman.h>

#define FUTEX_WAIT              0
#define FUTEX_WAKE              1
#define FUTEX_FD                2
#define FUTEX_REQUEUE           3
#define FUTEX_CMP_REQUEUE       4
#define FUTEX_WAKE_OP           5

#define FUTEX_OP_SET            0       /* *(int *)UADDR2 = OPARG; */
#define FUTEX_OP_ADD            1       /* *(int *)UADDR2 += OPARG; */
#define FUTEX_OP_OR             2       /* *(int *)UADDR2 |= OPARG; */
#define FUTEX_OP_ANDN           3       /* *(int *)UADDR2 &= ~OPARG; */
#define FUTEX_OP_XOR            4       /* *(int *)UADDR2 ^= OPARG; */

#define FUTEX_OP_OPARG_SHIFT    8       /* Use (1 << OPARG) instead of
OPARG.  */

#define FUTEX_OP_CMP_EQ         0       /* if (oldval == CMPARG) wake */
#define FUTEX_OP_CMP_NE         1       /* if (oldval != CMPARG) wake */
#define FUTEX_OP_CMP_LT         2       /* if (oldval < CMPARG) wake */
#define FUTEX_OP_CMP_LE         3       /* if (oldval <= CMPARG) wake */
#define FUTEX_OP_CMP_GT         4       /* if (oldval > CMPARG) wake */
#define FUTEX_OP_CMP_GE         5       /* if (oldval >= CMPARG) wake */

#define NUM_THREADS 8

int futex_wake_op(int *addr1, int *addr2, 
                  int nr_wake_1, int nr_wake_2, int encoded_op)
{
    syscall(SYS_futex, addr1, FUTEX_WAKE_OP, nr_wake_1, 
            nr_wake_2, addr2, encoded_op);
}

int futex1 = 0, futex2 = 0;

struct {
    int futex1;
    int futex2;
} *shared;

void *mapper(void *arg)
{
    for (;;) {
        struct timespec delay;
        void *mem;

        delay.tv_sec = 0;
        delay.tv_nsec = 100000000;

        mem = mmap(0, 16384, PROT_READ | PROT_WRITE, MAP_PRIVATE |
MAP_ANONYMOUS, -1, 0);

        if (mem == (void *) -1) {
            perror("mmap");
            exit(EXIT_FAILURE);
        }

        shared = mem;

        clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &delay, 0);

        if (munmap(mem, 16384) < 0) {
            perror("munmap");
            exit(EXIT_FAILURE);
        }
    }
}

void *waker(void *arg)
{
    int rand_state = 1;

    for (;;) {
        int val = rand_r(&rand_state) & 0xFFFF;
        const int op = (FUTEX_OP_SET << 28) | (FUTEX_OP_CMP_GT << 24) |
val;
        int result = futex_wake_op(&shared->futex1, &shared->futex2, 1,
1, op);

        if (result < 0 && errno != EFAULT) {
            perror("futex_wake_op");
            exit(EXIT_FAILURE);
        }
    }

    /* notreached */
    return 0;
}

int main(void)
{
    int i;
    srand(1);

    for (i = 0; i < NUM_THREADS; i++) {
        pthread_t thr;
        void *(*func)(void *) = (i == 0) ? mapper : waker;
        int result = errno = pthread_create(&thr, 0, func, 0);
        if (result != 0) {
            perror("pthread_create");
            return EXIT_FAILURE;
        }
    }

    pthread_exit(0);
}
