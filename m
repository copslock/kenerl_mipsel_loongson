Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA11138; Wed, 15 May 1996 23:23:37 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA20606 for linux-list; Thu, 16 May 1996 06:22:10 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA20601 for <linux@cthulhu.engr.sgi.com>; Wed, 15 May 1996 23:22:09 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA11092 for <lmlinux@neteng.engr.sgi.com>; Wed, 15 May 1996 23:22:08 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA20594; Wed, 15 May 1996 23:22:06 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id XAA13123; Wed, 15 May 1996 23:22:04 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id CAA21020; Thu, 16 May 1996 02:21:12 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id CAA10579; Thu, 16 May 1996 02:21:12 -0400
Date: Thu, 16 May 1996 02:21:12 -0400
Message-Id: <199605160621.CAA10579@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: nn@lanta.engr.sgi.com
CC: sparclinux-cvs@caipfs.rutgers.edu, torvalds@cs.helsinki.fi,
        lmlinux@neteng.engr.sgi.com
In-reply-to: <199605151640.JAA08277@lanta.engr.sgi.com>
	(nn@lanta.engr.sgi.com)
Subject: Re: numbers...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   Date: Wed, 15 May 1996 09:40:53 -0700
   From: nn@lanta.engr.sgi.com (Neal Nuckolls)

   > sun4m SS10 115mhz hypersparc, 256k cache
   > measure_csum_partial
   > csum_partial: sz[1024] 10000 iterations takes 17009430 microseconds
   > csum_partial: sz[1024] 1 iteration takes <1700 microseconds>==<332 nanoseconds>

   Maybe I'm dense this morning but I don't understand the numbers.

[NOTE: real lmbench results with the new checksum code in a bit, it's
       not as much of an improvement as I wanted and Solaris still
       gets better TCP bandwidth on localhost.]

The benchmark looks like:

	for(iter=0; iter < 10000; iter++) {
		for(inner=0; inner < 512; inner++) {
			csum(foo, bar, baz);
			flush_caches();
		}
	}

The 512 number is just imperical because for small buffers (less than
1k) doing just one iteration caused it impossible to measure anything
significant.

I am factoring in the time the cache flush takes.  I calculate how
long it takes to do the flush before the loop runs, then subtract that
value multiplied by (iter * inner) from the final time.

So the 17009430 microseconds is the time it takes to run the entire
loop structure minus the flushing overhead.

1700 microseconds is the time each run of the inner for loop took
again minus the flush overhead, 332 nanoseconds is the absolute time
each instance of the csum() took to run on the buffer once again this
is after subtracting the flush overhead.

Later,
David S. Miller
davem@caip.rutgers.edu
