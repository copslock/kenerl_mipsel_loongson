Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id CAA20067
	for <pstadt@stud.fh-heilbronn.de>; Thu, 15 Jul 1999 02:52:01 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA07208; Wed, 14 Jul 1999 17:50:33 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA14761
	for linux-list;
	Wed, 14 Jul 1999 17:46:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA87292
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 14 Jul 1999 17:46:34 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA02944
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jul 1999 17:46:32 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-10.uni-koblenz.de [141.26.131.10])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA10340
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jul 1999 02:46:28 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id CAA01379;
	Thu, 15 Jul 1999 02:38:57 +0200
Date: Thu, 15 Jul 1999 02:38:57 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Tim Hockin <thockin@cobaltnet.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Float / Double issues
Message-ID: <19990715023857.A1282@uni-koblenz.de>
References: <378AADF5.96152E0B@cobaltnet.com> <19990714235346.A1231@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=NzB8fVQJ5HfG6fxh
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19990714235346.A1231@uni-koblenz.de>; from Ralf Baechle on Wed, Jul 14, 1999 at 11:53:46PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii

On Wed, Jul 14, 1999 at 11:53:46PM +0200, Ralf Baechle wrote:

> > Hey gang - I have what seems to be two seperate issues on Mips/Linux
> > (cobalt boxes).
> > 
> > 1) Programs using doubles with pthreads get corrupted data in the
> > doubles.
> 
> That one is funny.  It was/is a longstanding libc bug originally reported
> by Dong Liu.  I actually thought it'd be fixed but now thanks to your
> report I see it's still broken.  So the multithreaded variant of your
> double.c doesn't work at all on our libc.
> 
> The bug is in glibc/sysdeps/unix/sysv/linux/mips/clone.S; I suppose
> Cobalt's libc which I last worked on late October is still using my
> old clone.S from that time or somebody else there came up with a funky
> new bug completly on it's own - which might explain why double.c cannot
> even successfully create the threads.
> 
> More later ...

It is later :-)

Attached are fixed versions of clone.S.  I also attach Dong's old test
program.  While now threads are working dong.c still fails for a large
number of threads, that is > 1000 or so with a SIGSEGV.  This of course
doesn't solve your problem yet, Tim - but now we've got the same problem ...

  Ralf

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="clone.S"

/* Copyright (C) 1996 Free Software Foundation, Inc.
   This file is part of the GNU C Library.
   Contributed by Ralf Baechle <ralf@gnu.ai.mit.edu>, 1996.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with the GNU C Library; see the file COPYING.LIB.  If not,
   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

/* clone() is even more special than fork() as it mucks with stacks
   and invokes a function in the right context after its all over.  */

#include <sys/asm.h>
#include <asm/unistd.h>
#include <sysdep.h>
#define _ERRNO_H	1
#include <errnos.h>

/* int clone(int (*fn)(void *arg), void *child_stack, int flags, void *arg) */

	.text
NESTED(__clone,4*SZREG,sp)
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	sp, 32
	.cprestore 16

#ifdef PROF
	.set	noat
	move	$1, ra
	jal	_mcount
	.set	at
#endif

	/* Sanity check arguments.  */
	li	v0, EINVAL
	beqz	a0, error	/* no NULL function pointers */
	beqz	a1, error	/* no NULL stack pointers */

	subu	a1, 32			# reserve argument save space
	sw	a0, 0(a1)		# save function pointer
	sw	a3, 4(a1)		# save argument pointer

	move	a0, a2			# Do the system call
	li	v0, __NR_clone
	syscall

	bnez	a3, error
	beqz	v0, __thread_start

	addiu	sp, 32
	ret

	/* Something bad happened -- no child created */
error:
	addiu	sp, 32
#ifdef __PIC__
	la	t9, __syscall_error
	jr	t9
#else
	j	__syscall_error
#endif
	END(__clone)

/* Load up the arguments to the function.  Put this block of code in
   its own function so that we can terminate the stack trace with our
   debug info.  */

ENTRY(__thread_start)
	/* cp is already loaded.  */
	.cprestore 16
	lw	t9, 0(sp)		# func ptr
	lw	a0, 4(sp)		# arg ptr

	/* Call the user's function */
	jalr		t9

	/* Call _exit rather than doing it inline for breakpoint purposes */
	move		a0, v0
	jal		_exit
	/* Unreached  */
	END(__thread_start)

weak_alias(__clone, clone)

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dliu.c"

#include <pthread.h>
#include <stdio.h>

void* new_thread(void* arg)
{
	int i;
	printf("Thread[%s] stack at %x\n",arg, &i);
	for (i = 0; i< 4; i++) {
	    printf("Thread[%s] %d\n", arg, i);
	    sched_yield();
	}
	return(NULL);
}

#define NUM_OF_THREAD 10000
main(int argc, char **argv)

{
        int num = NUM_OF_THREAD;
	pthread_t thread[NUM_OF_THREAD];
	
	char *args[NUM_OF_THREAD];
	int i;
	int last;
	void *status;

	if (argc > 1)
	    num = atoi(argv[1]);
	if (num>NUM_OF_THREAD)
	    num = NUM_OF_THREAD;
	printf("Original thread stack at %x\n", &i);

	for (i = 0 ; i < num; i++) {
	    args[i] = (char *)malloc(80);
	    sprintf(args[i], "%04d", i);
	    if (pthread_create(&thread[i],
			       NULL,
			       new_thread, (void *)args[i])) {
		printf("Error: creating new thread[%d]\n", i);
		break;
	    }
	}

	last = i;

	for (i = 0 ; i < last; i++) {
	    pthread_join(thread[i], &status);
	    printf("thread[%d] return status' address %p\n",i, status);
	}
	printf("%d threads created\n", last);
	exit(0);
}

--NzB8fVQJ5HfG6fxh--
