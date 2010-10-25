Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 22:12:23 +0200 (CEST)
Received: from tvwna-ip-c-172.princeton.org ([66.180.187.89]:37797 "EHLO
        localhost.m.enhanced.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491113Ab0JYUMU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 22:12:20 +0200
Received: from camm by localhost.m.enhanced.com with local (Exim 4.69)
        (envelope-from <camm@maguirefamily.org>)
        id 1PATO7-0001dz-Mg; Mon, 25 Oct 2010 16:11:23 -0400
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     debian-mips@lists.debian.org,
        Frederick Isaac <freddyisaac@gmail.com>, gcl-devel@gnu.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: recent SIGBUS/SIGSEGV mips kernel bug
References: <E1OwbkA-0006gv-Bi@localhost.m.enhanced.com>
        <4C93993E.7030008@caviumnetworks.com>
        <8762y49k1k.fsf@maguirefamily.org>
        <4C93D86D.5090201@caviumnetworks.com>
        <87fwx4dwu5.fsf@maguirefamily.org>
        <4C97D9A1.7050102@caviumnetworks.com>
        <87lj6te9t1.fsf@maguirefamily.org>
        <4C9A8BC9.1020605@caviumnetworks.com>
        <4C9A9699.6080908@caviumnetworks.com>
        <87pqvbs7oa.fsf@maguirefamily.org>
        <4CB88D2C.8020900@caviumnetworks.com>
        <87r5fksxby.fsf_-_@maguirefamily.org>
        <4CBF1B1E.6050804@caviumnetworks.com>
        <8762wwlfen.fsf@maguirefamily.org>
        <4CC06826.2070508@caviumnetworks.com>
        <4CC0787C.2040902@caviumnetworks.com>
From:   Camm Maguire <camm@maguirefamily.org>
Date:   Mon, 25 Oct 2010 16:11:21 -0400
In-Reply-To: <4CC0787C.2040902@caviumnetworks.com> (David Daney's message of "Thu\, 21 Oct 2010 10\:29\:32 -0700")
Message-ID: <87hbga3udy.fsf@maguirefamily.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <camm@maguirefamily.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: camm@maguirefamily.org
Precedence: bulk
X-list: linux-mips

Greetings, and thanks so much for this and the kernel fix!

I've committed a little test which hopefully will enable trapping
these signals when the kernel fix is in place:

--- o/sgbc.c	1 Oct 2010 19:15:40 -0000	1.9.4.1.2.12.6.1.2.1.6.4
+++ o/sgbc.c	25 Oct 2010 19:46:35 -0000
@@ -1146,10 +1146,6 @@
   memset(b1,32,2*p);
   memset(b2,0,p);
   memprotect_test_address=(void *)(((unsigned long)b1+p-1) & ~(p-1));
-  if (mprotect(memprotect_test_address,p,PROT_READ_EXEC)) {
-    memprotect_result=memprotect_cannot_protect;
-    return -1;
-  }
   sa.sa_sigaction=(void *)memprotect_handler_test;
   sa.sa_flags=MPROTECT_ACTION_FLAGS;
   if (sigaction(SIGSEGV,&sa,&sao)) {
@@ -1161,6 +1157,29 @@
     memprotect_result=memprotect_sigaction;
     return -1;
   }
+  { /* mips kernel bug test -- SIGBUS with no faddr when floating point is emulated. */
+    float *f1=(void *)memprotect_test_address,*f2=(void *)b2;
+  
+    if (mprotect(memprotect_test_address,p,PROT_READ_EXEC)) {
+      memprotect_result=memprotect_cannot_protect;
+      return -1;
+    }
+    memprotect_result=memprotect_bad_return;
+    *f1=*f2;
+    if (memprotect_result==memprotect_bad_return)
+      memprotect_result=memprotect_no_signal;
+    if (memprotect_result!=memprotect_none) {
+      sigaction(SIGSEGV,&sao,NULL);
+      sigaction(SIGBUS,&saob,NULL);
+      return -1;
+    }
+    memprotect_handler_invocations=0;
+
+  }
+  if (mprotect(memprotect_test_address,p,PROT_READ_EXEC)) {
+    memprotect_result=memprotect_cannot_protect;
+    return -1;
+  }
   memprotect_result=memprotect_bad_return;
   memset(memprotect_test_address,0,p);
   if (memprotect_result==memprotect_bad_return)

This seems to work, but if you see any shortcomings, please let me
know.

Thanks so much again!

David Daney <ddaney@caviumnetworks.com> writes:

> On 10/21/2010 09:19 AM, David Daney wrote:
>> On 10/20/2010 02:31 PM, Camm Maguire wrote:
>>> Greetings!
>>>
>>> Does this suffice?
>>>
>>> (sid)camm@gabrielli:~/maxima-5.22.1/tests$ uname -a
>>> Linux gabrielli 2.6.35.4-dsa-octeon #1 SMP Fri Sep 17 21:15:34 UTC
>>> 2010 mips64 GNU/Linux
>>> (sid)camm@gabrielli:~/maxima-5.22.1/tests$ cat /proc/cpuinfo
>>> system type : CUST_WSX16 (CN3860p3.X-500-EXP)
>>> processor : 0
>>> cpu model : Cavium Octeon V0.3
>> [...]
>>
>> Hah! I have those things piled up all around me.
>>
>> No guarantees, but I will try to reproduce it. If I can reproduce it, it
>> should be easy to fix.
>>
>
> Definitely a kernel bug.  Consider this program:
>
> ------------8<--------sigbus.c-------
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
>
> #include <sys/mman.h>
>
> int main(int argc, char *argv[])
> {
>   int pgsize;
>   float *p1;
>   float *p2;
>   int r;
>
>   pgsize = getpagesize();
>
>   p1 = mmap(NULL, pgsize, PROT_READ | PROT_WRITE,
> 	    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>
>   if (p1 == MAP_FAILED) {
>     perror("mmap p1 failed");
>     exit(1);
>   }
>
>   p2 = mmap(NULL, pgsize, PROT_READ | PROT_WRITE,
> 	    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>
>   if (p2 == MAP_FAILED) {
>     perror("mmap p2 failed");
>     exit(1);
>   }
>
>   *p1 = 2.5;
>   *p2 = 3.5;
>
>   r = mprotect(p1, pgsize, PROT_READ);
>   if (r) {
>     perror("mprotect p1 failed");
>     exit(1);
>   }
>
>   r = mprotect(p2, pgsize, PROT_READ);
>   if (r) {
>     perror("mprotect p2 failed");
>     exit(1);
>   }
>
>   *p2 = *p1;
>
>   asm volatile("" ::: "memory");
>
>   puts("All done!");
>
>   exit(0);
> }
> ------------8<-----------------------
>
> $ mips64-octeon-linux-gnu-gcc -Wall -mhard-float -march=mips64 -O3 -o 
> sigbus sigbus.c
> $ mips64-octeon-linux-gnu-objdump -d sigbus > sigbus.dis
>
> The float copy '*p2 = *p1;' dissassembles as:
>
>    120000b30:	c6400000 	lwc1	$f0,0(s2)
>    120000b34:	e6000000 	swc1	$f0,0(s0)
>
> When run on an FPU-less system I get:
>
> ~ # ./sigbus
> Bus error
>
> When run on my x86_64 workstation:
>
> $ ./sigbus
> Segmentation fault (core dumped)
>
> I will fix this kernel bug.
>
> David Daney
>
>
>
>

-- 
Camm Maguire			     		    camm@maguirefamily.org
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
