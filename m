Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2004 21:11:12 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:34037 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225947AbUE1UK7>;
	Fri, 28 May 2004 21:10:59 +0100
Received: from mercury.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.11/8.12.11) with ESMTP id i4SJurlE028757;
	Fri, 28 May 2004 12:56:53 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i4SK8iZR002985;
	Fri, 28 May 2004 13:08:45 -0700 (PDT)
Message-ID: <01ea01c444f0$03d6b8e0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <hadi@cyberus.ca>, <linux-mips@linux-mips.org>
Cc: <sibyte-users@bitmover.com>
References: <1085773008.1029.59.camel@jzny.localdomain>
Subject: Re: weird sb1250 behavior
Date: Fri, 28 May 2004 22:11:49 +0200
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This could be any one of a number of wierd effects that one sees
from time to time.  Rather than speculate, would it be too much
to ask you to run objdump --disassemble on the different versions
of your test program and post the results?

----- Original Message ----- 
From: "jamal" <hadi@cyberus.ca>
To: <linux-mips@linux-mips.org>
Cc: <sibyte-users@bitmover.com>
Sent: Friday, May 28, 2004 21:36
Subject: weird sb1250 behavior


> 
> found some very strange behavior with sb1250.
> Gcc 3.2.3 with sibyte mods. Running Linux 2.4.21 with whatever
> mods off sibyte.
> 
> Testcase:
> sending a large amount of traffic 
> -->eth0-->someprocessing-->eth1
> 
> given the nature of processing, say i was getting 100Kpps throughput.
> Now i fire a very basic program that has just loops and forever
> sums up two numbers.
> 
> ---
>       1 #include <stdlib.h>
>       2 
>       3 int main ()
>       4 {
>       5         int a = 1;
>       6         int b = 2;
>       7         int c = 0; 
>       8         // int c;
>       9         while (1) {
>      10                 c = a + b;
>      11         }
>      12 }
> --------
> 
> I see very little drop in throughput - probably around 0.01%.
> 
> Now comment line 7 then uncomment line 8. Hallelujah.
> Perfomance drops to about 100pps. Thats about a factor of 1000 down!
> 
> Interesting thing is if you add a nop (__asm__ __volatile__("nop");)
> in the second version just before the while loop, we get back the same
> performance as in the earlier version.
> Apologies in advance for attaching objdumps (since there maybe folks who
> dont have access to the sibyte tools)
> 1) while-init-dis is for case 1 where c is initialized
> 2) while-noinit-dis is for case 2 where c is not initialize
> 3) while-nop-dis is for case 3 when you have nop thrown in.
> 
> 
> cheers,
> jamal
> 
> 
