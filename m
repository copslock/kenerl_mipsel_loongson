Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f91Nqd900993
	for linux-mips-outgoing; Mon, 1 Oct 2001 16:52:39 -0700
Received: from atlrel6.hp.com (atlrel6.hp.com [192.151.27.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f91NqQD00989
	for <linux-mips@oss.sgi.com>; Mon, 1 Oct 2001 16:52:27 -0700
Received: from xatlrelay1.atl.hp.com (xatlrelay1.atl.hp.com [15.45.89.190])
	by atlrel6.hp.com (Postfix) with ESMTP id 4EF8D1F839
	for <linux-mips@oss.sgi.com>; Mon,  1 Oct 2001 19:52:17 -0400 (EDT)
Received: from xatlbh2.atl.hp.com (xatlbh2.atl.hp.com [15.45.89.187])
	by xatlrelay1.atl.hp.com (Postfix) with ESMTP id E56F91F521
	for <linux-mips@oss.sgi.com>; Mon,  1 Oct 2001 19:52:16 -0400 (EDT)
Received: by xatlbh2.atl.hp.com with Internet Mail Service (5.5.2653.19)
	id <T3VV5HBG>; Mon, 1 Oct 2001 19:52:16 -0400
Message-ID: <CBD6266EA291D5118144009027AA63353F922A@xboi05.boi.hp.com>
From: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Bug in pthread glibc 7.0 & 7.1
Date: Mon, 1 Oct 2001 19:52:15 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



The following code reveals a bug in the MIPS Gnu C Libraries available via
ftp on oss.sgi.com (ftp.linux.sgi.com).

The bug is posix thread related and occurs when using the libc and
libpthread versions available at:
/pub/linux/mips/redhat/7.1/RPMS/mipsel/glibc*

The bug also appears to exist in:
/pub/linux/mips/mipsel-linux/RedHat-7.0/RPMS/mipsel/glibc*

The bug does not exist in earlier versions of the pthread library, or on the
non-MIPS (non-SGI) distributions.  (ie. RedHat 7.0 for ix86 does not exhibit
a failure with this code, but RedHat 7.0/7.1 on mips does)

Upon failure the following code sequence will core dump (SEGV) instead of
exiting normally.


Thanks,

Roger Twede
Engineer/Scientist
Hewlett Packard Company


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
