Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UBADnC001135
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 04:10:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UBADHm001134
	for linux-mips-outgoing; Thu, 30 May 2002 04:10:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UBA4nC001126
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 04:10:05 -0700
Received: from aihana (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id EAA21036
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 04:10:18 -0700
Subject: (Re-Send) shmctl() returns corrupt value on pb1000.
From: Takeshi Aihana <takeshi_aihana@montavista.co.jp>
To: linux-mips <linux-mips@oss.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution/1.0.5-build 20020511 
Date: 30 May 2002 20:10:16 +0900
Message-Id: <1022757017.1045.47.camel@aihana>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

# Sorry, please ignore previous mail I send.

Hello all,

I have a problem now about return the segment size of shared memory from
shmctl() func.

First of step was to start apache_1.3.24 on kernel-2.4.17/pb1000.
However it could not be started because it might be currput segment size
from shmctl() called in apache.
So that I tried to test with shmctl() on
(A)kernel-2.4.17/pb1000/gcc-2.95.3 and (B)kernel-2.4.9/x86/gcc-2.95.3 as
the follows. 
(B) was just returned correct segment size, but (A)'s segment size was 0
(of cause memory on pb1000 was left).

This simple code is follows, and `gcc -o test test.c`.
-----------------------------------8<---------------------------------------
#include <stdio.h>
#include <sys/ipc.h>
#include <sys/shm.h>

int main (void) {
  int shm_id;

  struct shmid_ds ds;
  shm_id = shmget(IPC_PRIVATE, 123, IPC_CREAT|0666);

  if (shm_id < 0) {
    perror ("shmget");
    return 1;
  }

  if (shmctl(shm_id, IPC_STAT, &ds)) {
    perror ("shmctl");
    exit (1);
  }
  printf( "shm_segsz = %d\n", ds.shm_segsz);
}

-----------------------------------8<---------------------------------------

Then each results are,
 x86(kernel-2.4.9/RH-7.2/gcc-2.95.3) : shm_segsz = 123
 pb1000(kernel-2.4.17/gcc-2.95.3)    : shm_segsz = 0

This value of pb1000 could not be expected for me.

So if you have any adivices that should be add option to compile on
pb1000, or if you have been faced similar to this, 
please let me knows.

Thank you for your helps.
Regards.

---
(TAKESHI - MontaVista Software Japan)
