Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA5HIbc13407
	for linux-mips-outgoing; Mon, 5 Nov 2001 09:18:37 -0800
Received: from atlrel1.hp.com (atlrel1.hp.com [156.153.255.210])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA5HIM013403
	for <linux-mips@oss.sgi.com>; Mon, 5 Nov 2001 09:18:22 -0800
Received: from xatlrelay2.atl.hp.com (xatlrelay2.atl.hp.com [15.45.89.191])
	by atlrel1.hp.com (Postfix) with ESMTP
	id 80CE051F; Mon,  5 Nov 2001 12:18:21 -0500 (EST)
Received: from xatlbh1.atl.hp.com (xatlbh1.atl.hp.com [15.45.89.186])
	by xatlrelay2.atl.hp.com (Postfix) with ESMTP
	id C9C7D1F510; Mon,  5 Nov 2001 12:18:19 -0500 (EST)
Received: by xatlbh1.atl.hp.com with Internet Mail Service (5.5.2653.19)
	id <VPWQD532>; Mon, 5 Nov 2001 12:18:19 -0500
Message-ID: <CBD6266EA291D5118144009027AA63353F9255@xboi05.boi.hp.com>
From: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
To: "'Bradley D. LaRonde'" <brad@ltc.com>, Green <greeen@iii.org.tw>,
   Linux-mips <linux-mips@oss.sgi.com>, MipsMailList <linux-mips@fnet.fr>
Subject: RE: do_ri( )
Date: Mon, 5 Nov 2001 12:18:15 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've seen the same with glibc 2.2.4 on the QED RM5261 processor (Mips 5000).

I can take a multi-threaded application that runs without fail using glibc
2.2.2 and reproduce the failure using glibc 2.2.3 and glibc 2.2.4.

A small test app I wrote to exhibit the problem is included below.

I was using gcc 3.0 at the time.  I question whether gcc 2.96 might help
since the glibc variants at sgi.com were compiled using 2.96.

Regards,

Roger

// CODE STARTS BELOW


#include <assert.h>
#include <pthread.h>
#include <sched.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>


struct ThreadStartInfo {
    pthread_mutex_t InitCompleteMutex;
    pthread_cond_t InitCompleteCond;
    void * (*Func)(void *);
    void * Arg;
    int Priority;
    char * ThreadName;
    unsigned char InitCompleteCount;
};


static void * StartFunction(void * Arg)
{

   struct ThreadStartInfo * StartInfo = (struct ThreadStartInfo *) Arg;
   int result;
   void * retVal = 0;

   assert(Arg != NULL);

   result = pthread_mutex_lock(&(StartInfo->InitCompleteMutex));
   assert(result == 0);
   printf("pid=%d thread mutex locked at x%x\n", getpid(),
&(StartInfo->InitCompleteMutex));
   StartInfo->InitCompleteCount = 1;
   result = pthread_cond_signal(&(StartInfo->InitCompleteCond));
   assert(result == 0);
   printf("pid=%d thread cond signal sent, unlocking at 0x%x\n", getpid(),
&(StartInfo->InitCompleteMutex));
   result = pthread_mutex_unlock(&(StartInfo->InitCompleteMutex));
   assert(result == 0);
   printf("pid=%d thread unlocked\n", getpid());
   sched_yield();
   printf("pid=%d yielded and back again\n", getpid());

   return(retVal);


}




int main(void)
{
    pthread_t ThreadObject;
    struct ThreadStartInfo StartInfo;
    pthread_mutexattr_t mutexAttr;
    pthread_attr_t threadAttr;
    pthread_condattr_t condAttr;
    int result = 0;

    StartInfo.ThreadName = "mythread";

    result = pthread_mutexattr_init(&mutexAttr);
    assert(result == 0);
    printf("pid=%d Init mutex\n", getpid());
    result = pthread_mutex_init(&(StartInfo.InitCompleteMutex), &mutexAttr);
    assert(result == 0);

    result = pthread_condattr_init(&condAttr);
    assert(result == 0);
    result = pthread_cond_init(&(StartInfo.InitCompleteCond), &condAttr);
    assert(result == 0);

    StartInfo.InitCompleteCount = 0;

    pthread_mutex_lock(&(StartInfo.InitCompleteMutex));

    printf("pid=%d About to create thread: %s\n", getpid(),
StartInfo.ThreadName);
    result = pthread_attr_init(&threadAttr);
    assert(result == 0);
    result = pthread_create(&ThreadObject,
                              &threadAttr,
                              &StartFunction,
                              (void *)&StartInfo);
    assert(result == 0);
    while ((result == 0) && (StartInfo.InitCompleteCount == 0))
    {
        do
        {
	   printf("pid=%d about to cond_wait for %s init 1.\n", getpid(),
StartInfo.ThreadName);
    	   result = pthread_cond_wait(&(StartInfo.InitCompleteCond),
&(StartInfo.InitCompleteMutex));
    	   printf("pid=%d back from cond_wait for %s init 1.  result=%d\n",
getpid(), StartInfo.ThreadName, result);
        } while (result == EINTR);
    }

    result = pthread_mutex_unlock(&(StartInfo.InitCompleteMutex));
    assert(result == 0);

    getchar();
    return 0;
}


// CODE ABOVE


-----Original Message-----
From: Bradley D. LaRonde [mailto:brad@ltc.com]
Sent: Sunday, November 04, 2001 9:33 PM
To: Green; Linux-mips; MipsMailList
Subject: Re: do_ri( )


I've seen the same thing but on a different processor (VR5432).  gcc 3.0.1,
glibc 2.2.3.  I suspect stack/register corruption.

Regards,
Brad

----- Original Message -----
From: Green
To: Linux-mips ; MipsMailList
Sent: Sunday, November 04, 2001 10:43 PM
Subject: do_ri( )

Dear all,

    I often get into trouble executing multithread application.
    Sometimes it will appear the message " Illegal instruction = 0xXXXX " in
    do_ri() function in /arch/mips/kernel/traps.c.
    It happened randomly.

    Up to now, I still didn't know how to fix bug.
    If any one know how to fix it, please reply me.
    Appreciate in sincerely.

    P.S  My mips bos is R3912.

~~
Green  greeen@iii.org.tw
