Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6C945Rw016853
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 02:04:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6C945Ss016852
	for linux-mips-outgoing; Fri, 12 Jul 2002 02:04:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from smtp01ffm.de.uu.net (smtp01ffm.de.uu.net [192.76.144.150])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6C93nRw016838
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 02:03:50 -0700
Received: from e02.toshiba.de ([194.76.49.35])
	by smtp01ffm.de.uu.net (5.5.5/5.5.5) with SMTP id LAA26656
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 11:08:25 +0200 (MET DST)
Received: FROM dus05a.tsb-eu.com BY e02.toshiba.de ; Fri Jul 12 11:08:22 2002 +0200
Received: from dus04a.tsb-eu.com ([194.39.88.158]) by dus05a.tsb-eu.com with Microsoft SMTPSVC(5.0.2195.4905);
	 Fri, 12 Jul 2002 11:08:22 +0200
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Subject: RE: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
Date: Fri, 12 Jul 2002 11:08:22 +0200
Message-ID: <CEEE372345CE51438B0EC15F09ADE2710910F8@dus04a.tsb-eu.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
Thread-Index: AcIo+RJwV6xhrMQsQLyh3JmpnsUzjwAfFEjA
From: "Sedjai, Mohamed" <MSedjai@tee.toshiba.de>
To: "Jon Burgess" <Jon_Burgess@eur.3com.com>,
   "Ralf Baechle" <ralf@oss.sgi.com>
Cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>, <linux-mips@oss.sgi.com>,
   <carstenl@mips.com>
X-OriginalArrivalTime: 12 Jul 2002 09:08:23.0132 (UTC) FILETIME=[AC8001C0:01C22983]
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g6C93pRw016841
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello everybody,

I've been following this thread with much attention and interest,
and I would like to give my small contribution, even though my expertise
is far lower than yours.

Our TX49 (R4000 based) manual also states that "if the CACHE instruction
is issued for the line in which this instruction exists the operation 
is not guaranted". As you can see from the arch/mips/mm/r4xx0.c file, 
TX49 routines always disable caches before operating. 

Recently, one of our customer, raised the question since he was comparing
performance between TX49 and another comparable MIPS architecture. 
He noticed a huge difference in favor of the other vendor.
For information it was a multimedia application. Investigations
showed that the other vendor was running cache flushing operations cached. 
He tried to also run TX49 cached and, miracle, TX49 performed much better 
than the other chip. And the application could run for hours without
crashing.

I have contacted our designers, and the answer I got so far is that a problem can
occur depending on the alignement of the CACHE instructions and on the set
in which they are located (TX49 cache is 4 way set). This confirms Jon's 
investigation. Carsten, can you comment this, as a MIPS insider ? Which
CPUs are concerned ?

Further investigation are now ongoing to find a proper workaround and thus suggestions 
are highly apreciated.

>From my side I have a very simple question:

If you run instruction cache flushing cached, then the cache will be dirty
when the routine returns. At least the line(s) containing the routine itself ?
Or am I missing something ?

Best Regards,

Mohamed SEDJAI
TOSHIBA Electronics Europe 

PS: Sorry Dominic for a possible misusage of the terminology. BTW I found your book 
wonderfully well written and consider it as a reference to anyone who wants 
to write a technical book. 










-----Original Message-----
From: Jon Burgess [mailto:Jon_Burgess@eur.3com.com]
Sent: Donnerstag, 11. Juli 2002 18:34
To: Ralf Baechle
Cc: Gleb O. Raiko; linux-mips@oss.sgi.com; carstenl@mips.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with
gcc-2.96




> Ralf wrote:
>Have you tried to insert a large number of nops instead?

My investigation suggests that a single extra nop is sufficient. I have also
tried inserting extra nops before the cache routine to see if the relative
alignment of the instructions with respect to the cacheline has an influence,
but it has no effect. I am suspicious that if this occurs with the instruction
following the loop then something odd might be occuring on every loop iteration
as well. I might try adjusting the instructions in the loop to see if that has
any effect.

>  Or preferably,
>how about replacing the __restore_flags() in your example with the
>following piece of inline assembler:
>
>  __asm__ __volatile__("mtc0\t%0, $12" ::"r" (flags) : "memory");

I am happy that the current assembler code looks correct, but this change would
make it simpler.

     Jon
