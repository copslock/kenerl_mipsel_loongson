Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6C9bZRw017856
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 02:37:35 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6C9bZ2D017854
	for linux-mips-outgoing; Fri, 12 Jul 2002 02:37:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6C9bHRw017844;
	Fri, 12 Jul 2002 02:37:18 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6C9f2Xb015725;
	Fri, 12 Jul 2002 02:41:02 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA29174;
	Fri, 12 Jul 2002 02:41:00 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6C9f0b14558;
	Fri, 12 Jul 2002 11:41:00 +0200 (MEST)
Message-ID: <3D2EA42B.5270BF76@mips.com>
Date: Fri, 12 Jul 2002 11:40:59 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Sedjai, Mohamed" <MSedjai@tee.toshiba.de>
CC: Jon Burgess <Jon_Burgess@eur.3com.com>, Ralf Baechle <ralf@oss.sgi.com>,
   "Gleb O. Raiko" <raiko@niisi.msk.ru>, linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <CEEE372345CE51438B0EC15F09ADE2710910F8@dus04a.tsb-eu.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Sedjai, Mohamed" wrote:

> Hello everybody,
>
> I've been following this thread with much attention and interest,
> and I would like to give my small contribution, even though my expertise
> is far lower than yours.
>
> Our TX49 (R4000 based) manual also states that "if the CACHE instruction
> is issued for the line in which this instruction exists the operation
> is not guaranted". As you can see from the arch/mips/mm/r4xx0.c file,
> TX49 routines always disable caches before operating.
>
> Recently, one of our customer, raised the question since he was comparing
> performance between TX49 and another comparable MIPS architecture.
> He noticed a huge difference in favor of the other vendor.
> For information it was a multimedia application. Investigations
> showed that the other vendor was running cache flushing operations cached.
> He tried to also run TX49 cached and, miracle, TX49 performed much better
> than the other chip. And the application could run for hours without
> crashing.
>
> I have contacted our designers, and the answer I got so far is that a problem can
> occur depending on the alignement of the CACHE instructions and on the set
> in which they are located (TX49 cache is 4 way set). This confirms Jon's
> investigation. Carsten, can you comment this, as a MIPS insider ? Which
> CPUs are concerned ?

I can only speak for our own products (4Kc serie, 5Kc serie and 20Kc).
They have no problem with running the cache routine from cached space.

"Index load/store Tag" cache operation instructions, however should be executed from
uncached space, but they are not used in linux.

>
> Further investigation are now ongoing to find a proper workaround and thus suggestions
> are highly apreciated.
>
> >From my side I have a very simple question:
>
> If you run instruction cache flushing cached, then the cache will be dirty
> when the routine returns. At least the line(s) containing the routine itself ?
> Or am I missing something ?
>
> Best Regards,
>
> Mohamed SEDJAI
> TOSHIBA Electronics Europe
>
> PS: Sorry Dominic for a possible misusage of the terminology. BTW I found your book
> wonderfully well written and consider it as a reference to anyone who wants
> to write a technical book.
>
> -----Original Message-----
> From: Jon Burgess [mailto:Jon_Burgess@eur.3com.com]
> Sent: Donnerstag, 11. Juli 2002 18:34
> To: Ralf Baechle
> Cc: Gleb O. Raiko; linux-mips@oss.sgi.com; carstenl@mips.com
> Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with
> gcc-2.96
>
> > Ralf wrote:
> >Have you tried to insert a large number of nops instead?
>
> My investigation suggests that a single extra nop is sufficient. I have also
> tried inserting extra nops before the cache routine to see if the relative
> alignment of the instructions with respect to the cacheline has an influence,
> but it has no effect. I am suspicious that if this occurs with the instruction
> following the loop then something odd might be occuring on every loop iteration
> as well. I might try adjusting the instructions in the loop to see if that has
> any effect.
>
> >  Or preferably,
> >how about replacing the __restore_flags() in your example with the
> >following piece of inline assembler:
> >
> >  __asm__ __volatile__("mtc0\t%0, $12" ::"r" (flags) : "memory");
>
> I am happy that the current assembler code looks correct, but this change would
> make it simpler.
>
>      Jon

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
