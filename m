Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6F9CDRw026960
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 02:12:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6F9CCUH026959
	for linux-mips-outgoing; Mon, 15 Jul 2002 02:12:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6F9C0Rw026933
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 02:12:05 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id NAA27122;
	Mon, 15 Jul 2002 13:16:31 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id NAA13786; Mon, 15 Jul 2002 13:15:35 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id NAA08712; Mon, 15 Jul 2002 13:11:19 +0400 (MSK)
Message-ID: <3D3292E0.40FE937B@niisi.msk.ru>
Date: Mon, 15 Jul 2002 13:16:16 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <Pine.GSO.3.96.1020712204324.7646H-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
>  Well, I certainly understand what you mean, from the beginning, actually,
> but I still can't see why this would happen for a real implementation.
> When a cache miss happens an instruction word is read directly from the
> main memory to the pipeline and a cache fill happens "accidentally".
> 
>  What you describe, would require a CPU to query a cache status somehow
> during a fill (what if another fill is in progress? -- a cache controller
> may perform a fill of additional lines itself as it happens in certain
> implementations) and then issue a second read when the fill completes.
> That looks weird to me -- why would you design it this way?
> 

A cache is filled in cachline units. There is a possibility to fill only
part of cacheline in one cache and to store the rest of data in another
cache on the switch. Both caches will set the valid bit on this
cacheline, but only part of cacheline is valid. In the worst cache, this
operation may load instructions that will be reused later, for example,
part of the main loop of the cache invalidation (sic!) routine.

Unfortunately, the behaviour depends on whether miss occurs, what
instructions are loaded, how they are aligned, and so on. It means, if
you get crash on this kernel version, you won't get a crash on another.
If you add debug routines, everything is OK. Other black magic tricks
are also here. (As you may guess, I explain my real experience here.
:-). Analyzer doesn't help, bus transactions look good.)

In order to avoid this, CPU shall either perform the check again or
freeze everything on the cache swap operation. The latter doesn't look
real. Anyway, it's a lot of additional unnatural logic. So, the
requirement to run swapping operation uncached looks reasonable.

Regards,
Gleb.
