Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GAH6Rw023129
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 03:17:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GAH65V023128
	for linux-mips-outgoing; Tue, 16 Jul 2002 03:17:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GAGpRw023115
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 03:16:54 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id OAA13009;
	Tue, 16 Jul 2002 14:21:29 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id OAA19439; Tue, 16 Jul 2002 14:20:40 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id OAA25030; Tue, 16 Jul 2002 14:16:34 +0400 (MSK)
Message-ID: <3D33F38A.1866E8BB@niisi.msk.ru>
Date: Tue, 16 Jul 2002 14:20:58 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <Pine.GSO.3.96.1020716104018.20654A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
X-MIME-Autoconverted: from 8bit to quoted-printable by t111.niisi.ras.ru id OAA13009
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g6GAGtRw023120
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
>  Well, it looks possible for a CPU with cache lines wider than 32-bits
> (are there any such R3k-class CPUs?), indeed.

Yes, IDT R3081 has 16-byte I-cacheline. It also may have 16-byte
D-cacheline, it depends on DB Refill set, may be set by wiring and in
software too. DB Refill is here to support burst reads modern DRAMs
have. 

> 
> > Unfortunately, the behaviour depends on whether miss occurs, what
> > instructions are loaded, how they are aligned, and so on. It means, if
> > you get crash on this kernel version, you won't get a crash on another.
> > If you add debug routines, everything is OK. Other black magic tricks
> > are also here. (As you may guess, I explain my real experience here.
> > :-). Analyzer doesn't help, bus transactions look good.)
> 
>  How true -- I've seen such nastinesses, too. :-/  Except that I don't
> have an analyzer.

Don't care, it doesn't help in such situations.

> 
> > In order to avoid this, CPU shall either perform the check again or
> > freeze everything on the cache swap operation. The latter doesn't look
> > real. Anyway, it's a lot of additional unnatural logic. So, the
> > requirement to run swapping operation uncached looks reasonable.
> 
>  Well, the simplest effective approach would be a third alternative, i.e.
> to make swapping happen only when no fill is in progress.  Trivial logic
> with a single D latch on the swap signal should suffice -- I don't think
> the save on omitting it is worth breaking architecture specs and
> performance.
> 

In two words, it's unclear when there are no fills. Too much situations,
additional stall condition (which may break spec anyway). I can't
present full explanation, sorry. You have to believe. :-)

BTW, I reread my R3081 HW Manual and found two intresting places about
cache operation:

"These mechanisms [cache sizing, cache flushing] are enabled through the
use of the “IsC” (Isolate Cache) and SwC (Swap Cache) bits of the status
register, which resides in the on-chip System Control Co-Processor
(CP0). Instructions which immediately precede and succeed these
operations must not be cacheable, so that the actual swapping/isolation
of the cache does not disrupt operation."

Note precede instructions.
Then, on cache sizeing:

"Cache Sizing

[Famous algorithm that we implement]

Note that this software should operate as uncached. Once this algorithm
is done, software should return the caches to their normal state by
performing either a complete cache flush or an invalidate of those cache
lines modified by the sizing algorithm."

Regards,
Gleb.
