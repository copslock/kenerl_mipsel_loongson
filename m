Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CANHRw018284
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 03:23:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CANHDO018283
	for linux-mips-outgoing; Fri, 12 Jul 2002 03:23:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CAN6Rw018274
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 03:23:10 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id OAA19376;
	Fri, 12 Jul 2002 14:27:30 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id OAA32163; Fri, 12 Jul 2002 14:25:05 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id OAA24830; Fri, 12 Jul 2002 14:22:26 +0400 (MSK)
Message-ID: <3D2EAEF2.C06AFD05@niisi.msk.ru>
Date: Fri, 12 Jul 2002 14:26:58 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <Pine.GSO.3.96.1020711173440.7876G-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Thu, 11 Jul 2002, Gleb O. Raiko wrote:
> 
> > Have to check the cacheline at given address again. D-cache may have the
> > valid bit set for the cacheline at the same address. Address means
> > location in a cache, not memory. Check at address requires one extra
> > tick as opposed to checking the bit.
> 
>  Well, you issue an instruction word read from the cache.  The answer is
> either a hit, providing a word at the data bus at the same time (so you
> can't get a hit from one cache and data from the other) or a miss with no
> valid data -- you have to stall in this case, waiting for a refill.  

Let it be miss and stall.

>Then
> when data from the main memory arrives, it is latched in the cache (it
> doesn't really matter, which one now -- if it's the wrong one, then
> another refill will happen next time the memory address is dereferenced)
> and provided to the CPU at the same time.

At this time, CPU continues the execution of previous stalled
instruction. CPU knows the stalled instruction is in I-cache, but,
unfortunately, caches have been swapped already. The same cacheline in
the D-cache was valid bit set. CPU get data instead of code.

Regards,
Gleb.
