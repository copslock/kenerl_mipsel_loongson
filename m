Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA01100; Wed, 15 May 1996 09:42:21 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA26408 for linux-list; Wed, 15 May 1996 16:40:57 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA26403 for <linux@cthulhu.engr.sgi.com>; Wed, 15 May 1996 09:40:55 -0700
Received: from lanta.engr.sgi.com (lanta.engr.sgi.com [192.26.75.15]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA01002 for <lmlinux@neteng.engr.sgi.com>; Wed, 15 May 1996 09:40:55 -0700
Received: by lanta.engr.sgi.com (940816.SGI.8.6.9/911001.SGI)
	 id JAA08277; Wed, 15 May 1996 09:40:53 -0700
Date: Wed, 15 May 1996 09:40:53 -0700
From: nn@lanta.engr.sgi.com (Neal Nuckolls)
Message-Id: <199605151640.JAA08277@lanta.engr.sgi.com>
To: davem@caip.rutgers.edu
Subject: Re: numbers...
Cc: sparclinux-cvs@caipfs.rutgers.edu, torvalds@cs.helsinki.fi,
        lmlinux@neteng.engr.sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> sun4m SS10 115mhz hypersparc, 256k cache
> measure_csum_partial
> csum_partial: sz[1024] 10000 iterations takes 17009430 microseconds
> csum_partial: sz[1024] 1 iteration takes <1700 microseconds>==<332 nanoseconds>

Maybe I'm dense this morning but I don't understand the numbers.

You measure the realtime to do a sequential IP checksum on a 1K
buffer and you always invalidate the processor cache (I$, D$, and
Secondary$ or just some subset of these?) and don't include the
cost of doing the cache invalidate in the time above.  10000 of
these costs a hair over 17s, divide by 10000 gives 1.7ms per
iteration. This seems way high so must include the cost of the
cache invalidate or something?

What does the 332ns refer to?

My back of the envelope:
If I recall, the cacheline on a sun4m is 32bytes.  Assuming
something in the 300-600ns/secondarycachemiss range and a single
pending cachemiss at a time would put most any "touch the data"
operation on 1K of data in the 9.6-19.2us ballpark or 9-18ns/byte
range.

Does the hypersparc processor support multiple concurrent cache
misses? Or does it have a Viking-like sequential reference
detector and automatic cache prefetch logic?

> sun4m MicroSparcI, 40mhz, 16k icache 20k dcache
> ...
> Thats around 2.5us/Kbyte for csum, 

This must be hot$ that you're talking about?  Exactly when do you
invalidate the caches?

thanks.

neal
