Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 10:25:25 +0100 (CET)
Received: from p508B747B.dip.t-dialin.net ([80.139.116.123]:16873 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1121742AbSKYJZY>; Mon, 25 Nov 2002 10:25:24 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAP9Ox931362;
	Mon, 25 Nov 2002 10:24:59 +0100
Date: Mon, 25 Nov 2002 10:24:59 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: atul srivastava <atulsrivastava9@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
Message-ID: <20021125102458.B22046@linux-mips.org>
References: <20021125075238.28848.qmail@webmail36.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021125075238.28848.qmail@webmail36.rediffmail.com>; from atulsrivastava9@rediffmail.com on Mon, Nov 25, 2002 at 07:52:38AM -0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 25, 2002 at 07:52:38AM -0000, atul srivastava wrote:

>                  LEAF(__watch_set)
>                  li      t0,0x80000000
>                  subu    a0,t0
>                  ori     a0,7
>                  xori    a0,7
>                  or      a0,a1
>                  mtc0    a0,CP0_WATCHLO
>                  .......
> 
> it is loading the physical address of KSEG0 addresses in CP0 
> watchpoint register.

Additional problem - I know of at least one CPU on which the watch register
does not work for KSEG0 but only for TLB mapped registers.  That CPU
doesn't document this behaviour btw.

> in change history of this file i am able to see  KSEG0 restriction 
> removed only for arch/mips64/lib/watch.S...

The hw takes physical addresses, so using a a virtual address as argument
for __watch_set seemed to be stupid anyway.  The hw takes a physical
address and the conversion is best done in C anyway.

> while my manual is not specific about KSEG0 , can i safely use it 
> for all addresses ,offcourse then above assembly has to be 
> modified appropiately for addresses of different regions..

The whole watch stuff in the the kernel is pretty much an ad-hoc API
which I did create to debug a stack overflow.  I'm sure if you're
going to use it you'll find problems.  For userspace for example you'd
have to switch the watch register when switching the MMU context so
each process gets it's own virtual watch register.  Beyond that there
are at least two different formats of watch registers implemented in
actual silicon, the original R4000-style and the MIPS32/MIPS64 style
watch registers and the kernel's watch code only know the R4000 style
one.  So check your CPU's manual ...

  Ralf
