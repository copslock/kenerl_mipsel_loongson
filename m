Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2004 21:21:47 +0100 (BST)
Received: from mother.pmc-sierra.com ([IPv6:::ffff:216.241.224.12]:3581 "HELO
	mother.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225978AbUE1UVd>; Fri, 28 May 2004 21:21:33 +0100
Received: (qmail 26863 invoked from network); 28 May 2004 20:20:31 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by mother.pmc-sierra.com with SMTP; 28 May 2004 20:20:31 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id i4SKKTOM030716;
	Fri, 28 May 2004 13:20:30 -0700
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <KPDYN55R>; Fri, 28 May 2004 13:20:29 -0700
Message-ID: <9DFF23E1E33391449FDC324526D1F2590283C58B@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
From: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>
To: "'hadi@cyberus.ca'" <hadi@cyberus.ca>, linux-mips@linux-mips.org
Cc: sibyte-users@bitmover.com
Subject: RE: weird sb1250 behavior
Date: Fri, 28 May 2004 13:11:38 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Adam_Kiepul@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Adam_Kiepul@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Jamal,

There is a possible cache line read-after-write pseudo-dependency that, along with the code alignment in terms of the instruction pair doublewords, may do something weird to the sb1250 pipeline. Just my guess.

Have a great weekend,

Adam


-----Original Message-----
From: jamal [mailto:hadi@cyberus.ca]
Sent: Friday, May 28, 2004 12:37 PM
To: linux-mips@linux-mips.org
Cc: sibyte-users@bitmover.com
Subject: weird sb1250 behavior



found some very strange behavior with sb1250.
Gcc 3.2.3 with sibyte mods. Running Linux 2.4.21 with whatever
mods off sibyte.

Testcase:
sending a large amount of traffic 
-->eth0-->someprocessing-->eth1

given the nature of processing, say i was getting 100Kpps throughput.
Now i fire a very basic program that has just loops and forever
sums up two numbers.

---
      1 #include <stdlib.h>
      2 
      3 int main ()
      4 {
      5         int a = 1;
      6         int b = 2;
      7         int c = 0; 
      8         // int c;
      9         while (1) {
     10                 c = a + b;
     11         }
     12 }
--------

I see very little drop in throughput - probably around 0.01%.

Now comment line 7 then uncomment line 8. Hallelujah.
Perfomance drops to about 100pps. Thats about a factor of 1000 down!

Interesting thing is if you add a nop (__asm__ __volatile__("nop");)
in the second version just before the while loop, we get back the same
performance as in the earlier version.
Apologies in advance for attaching objdumps (since there maybe folks who
dont have access to the sibyte tools)
1) while-init-dis is for case 1 where c is initialized
2) while-noinit-dis is for case 2 where c is not initialize
3) while-nop-dis is for case 3 when you have nop thrown in.


cheers,
jamal
