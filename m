Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA2813134 for <linux-archive@neteng.engr.sgi.com>; Tue, 28 Apr 1998 11:56:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA17739916
	for linux-list;
	Tue, 28 Apr 1998 11:55:51 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA17616671
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 28 Apr 1998 11:55:44 -0700 (PDT)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id LAA14468
	for <linux@cthulhu.engr.sgi.com>; Tue, 28 Apr 1998 11:55:43 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id OAA16001; Tue, 28 Apr 1998 14:57:55 -0400
Date: Tue, 28 Apr 1998 15:11:31 -0400
Message-Id: <199804281911.PAA09285@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: glibc problem
In-Reply-To: <19980428013350.27295@uni-koblenz.de>
References: <199804222119.RAA20883@pluto.npiww.com>
	<19980423050447.63659@uni-koblenz.de>
	<199804241600.MAA05998@pluto.npiww.com>
	<199804272337.TAA14149@pluto.npiww.com>
	<19980428013350.27295@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Mon, Apr 27, 1998 at 07:37:42PM -0400, Dong Liu wrote:
 > 
 > > Sorry, I didn't install it properly, now my program links, but it
 > > still give segementation fault.
 > 
 > Ok.  I have to admit that I never tested any kind of multithread application.
 > If you could provide the code for the program in question, that'd be
 > helpful.
 > 
 >   Ralf
 > 

How about this

---- create-thread.c----

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

#define NUM_OF_THREAD 100
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
	if (num>100)
	    num = 100;
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
