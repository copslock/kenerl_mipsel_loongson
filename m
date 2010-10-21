Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2010 19:29:52 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10172 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491033Ab0JUR3s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Oct 2010 19:29:48 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cc078a70000>; Thu, 21 Oct 2010 10:30:15 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 21 Oct 2010 10:30:00 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 21 Oct 2010 10:30:00 -0700
Message-ID: <4CC0787C.2040902@caviumnetworks.com>
Date:   Thu, 21 Oct 2010 10:29:32 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Camm Maguire <camm@maguirefamily.org>,
        debian-mips@lists.debian.org,
        Frederick Isaac <freddyisaac@gmail.com>, gcl-devel@gnu.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: recent SIGBUS/SIGSEGV mips kernel bug
References: <E1OwbkA-0006gv-Bi@localhost.m.enhanced.com>        <4C93993E.7030008@caviumnetworks.com>   <8762y49k1k.fsf@maguirefamily.org>      <4C93D86D.5090201@caviumnetworks.com>   <87fwx4dwu5.fsf@maguirefamily.org>      <4C97D9A1.7050102@caviumnetworks.com>   <87lj6te9t1.fsf@maguirefamily.org>      <4C9A8BC9.1020605@caviumnetworks.com>   <4C9A9699.6080908@caviumnetworks.com>   <87pqvbs7oa.fsf@maguirefamily.org>      <4CB88D2C.8020900@caviumnetworks.com>   <87r5fksxby.fsf_-_@maguirefamily.org>   <4CBF1B1E.6050804@caviumnetworks.com> <8762wwlfen.fsf@maguirefamily.org> <4CC06826.2070508@caviumnetworks.com>
In-Reply-To: <4CC06826.2070508@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2010 17:30:00.0931 (UTC) FILETIME=[96F1EB30:01CB7145]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/21/2010 09:19 AM, David Daney wrote:
> On 10/20/2010 02:31 PM, Camm Maguire wrote:
>> Greetings!
>>
>> Does this suffice?
>>
>> (sid)camm@gabrielli:~/maxima-5.22.1/tests$ uname -a
>> Linux gabrielli 2.6.35.4-dsa-octeon #1 SMP Fri Sep 17 21:15:34 UTC
>> 2010 mips64 GNU/Linux
>> (sid)camm@gabrielli:~/maxima-5.22.1/tests$ cat /proc/cpuinfo
>> system type : CUST_WSX16 (CN3860p3.X-500-EXP)
>> processor : 0
>> cpu model : Cavium Octeon V0.3
> [...]
>
> Hah! I have those things piled up all around me.
>
> No guarantees, but I will try to reproduce it. If I can reproduce it, it
> should be easy to fix.
>

Definitely a kernel bug.  Consider this program:

------------8<--------sigbus.c-------
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <sys/mman.h>

int main(int argc, char *argv[])
{
   int pgsize;
   float *p1;
   float *p2;
   int r;

   pgsize = getpagesize();

   p1 = mmap(NULL, pgsize, PROT_READ | PROT_WRITE,
	    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

   if (p1 == MAP_FAILED) {
     perror("mmap p1 failed");
     exit(1);
   }

   p2 = mmap(NULL, pgsize, PROT_READ | PROT_WRITE,
	    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

   if (p2 == MAP_FAILED) {
     perror("mmap p2 failed");
     exit(1);
   }

   *p1 = 2.5;
   *p2 = 3.5;

   r = mprotect(p1, pgsize, PROT_READ);
   if (r) {
     perror("mprotect p1 failed");
     exit(1);
   }

   r = mprotect(p2, pgsize, PROT_READ);
   if (r) {
     perror("mprotect p2 failed");
     exit(1);
   }

   *p2 = *p1;

   asm volatile("" ::: "memory");

   puts("All done!");

   exit(0);
}
------------8<-----------------------

$ mips64-octeon-linux-gnu-gcc -Wall -mhard-float -march=mips64 -O3 -o 
sigbus sigbus.c
$ mips64-octeon-linux-gnu-objdump -d sigbus > sigbus.dis

The float copy '*p2 = *p1;' dissassembles as:

    120000b30:	c6400000 	lwc1	$f0,0(s2)
    120000b34:	e6000000 	swc1	$f0,0(s0)

When run on an FPU-less system I get:

~ # ./sigbus
Bus error

When run on my x86_64 workstation:

$ ./sigbus
Segmentation fault (core dumped)

I will fix this kernel bug.

David Daney
