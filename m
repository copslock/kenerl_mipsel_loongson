Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 11:02:57 +0100 (CET)
Received: from [203.199.83.245] ([203.199.83.245]:7869 "HELO
	mailweb33.rediffmail.com") by linux-mips.org with SMTP
	id <S1121742AbSKYKC4>; Mon, 25 Nov 2002 11:02:56 +0100
Received: (qmail 6472 invoked by uid 510); 25 Nov 2002 10:01:52 -0000
Date: 25 Nov 2002 10:01:52 -0000
Message-ID: <20021125100152.6471.qmail@mailweb33.rediffmail.com>
Received: from unknown (203.200.7.93) by rediffmail.com via HTTP; 25 nov 2002 10:01:52 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Re: watch exception only for kseg0 addresses..?
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

>
> > in change history of this file i am able to see  KSEG0 
>restriction
> > removed only for arch/mips64/lib/watch.S...
>
>The hw takes physical addresses, so using a a virtual address as 
>argument >for __watch_set seemed to be stupid anyway.  The hw 
>takes a physical address and the conversion is best done in C 
>anyway.

>The whole watch stuff in the the kernel is pretty much an ad-hoc 
>API
>which I did create to debug a stack overflow.  I'm sure if 
>you're
>going to use it you'll find problems.  For userspace for example 
>you'd
>have to switch the watch register when switching the MMU context 
>so
>each process gets it's own virtual watch register.
Beyond that there
>are at least two different formats of watch registers implemented 
>in
>actual silicon, the original R4000-style and the MIPS32/MIPS64 
>style
>watch registers and the kernel's watch code only know the R4000 
>style

my cpu manual ( IDT RC32334) talks about two watch registers 
CP0_IWATCH and CP0_DWATCH where it is required to just put desired 
VIRTUAL( bits 2--31) addresses to be watched , there is no mention 
of CP0_WATCHLO and CP0_WATCHHI .

additionally i guees for userspace virtual watch register problem, 
the hardware takes care of all , i just need to specify my virual 
address this is what i understand from my  manual.

and one more problem i face when i try to debug a mysterious page 
fault problem, that i get my watch exception but after page fault 
..hence I can't really debug , shouldn't the priority of watch 
exceptions should be higher than atleast instruction fetch 
exception.? or the scope of debugging by watch exception is 
limited by design.....
