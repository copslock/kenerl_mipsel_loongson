Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA29009; Sat, 18 May 1996 22:45:32 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA16148 for linux-list; Sun, 19 May 1996 05:45:26 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA16130 for <linux@cthulhu.engr.sgi.com>; Sat, 18 May 1996 22:45:24 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA29006 for <lmlinux@neteng.engr.sgi.com>; Sat, 18 May 1996 22:45:22 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA16118 for <lmlinux@neteng.engr.sgi.com>; Sat, 18 May 1996 22:45:21 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id WAA22054; Sat, 18 May 1996 22:45:20 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id BAA12139; Sun, 19 May 1996 01:45:18 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id BAA21316; Sun, 19 May 1996 01:45:17 -0400
Date: Sun, 19 May 1996 01:45:17 -0400
Message-Id: <199605190545.BAA21316@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: ecd@skynet.be
CC: lmlinux@neteng.engr.sgi.com, sparclinux-cvs@vger.rutgers.edu,
        alan@cymru.net, torvalds@cs.helsinki.fi
Subject: idea for csum_partial_copy on Viking/MXCC
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


(Note: This is just another one of my crazy ideas, consider this
 something to do possibly in the future when someone has tons of
 copious free time.  For now I'm going to get the software version
 working as fast as it can.)

(Some background for some of you, Viking/MXCC Sparc has a hardware
 block copy facility which can copy cache sub-block aligned chunks of
 ram very quickly.)

This is silly, but it would get disgustingly fast numbers. (btw,
eddie, still waiting for the memcpy.s of yours so that I can do some
testing tonight...)

You use the MXCC stream copy stuff if you have a buffer bigger than
256 bytes and you can align it to 32 bytes.  The unrolled loops right
now look like:

	ldd	[%src + offset + 0x18], %t0;	! multi-cycle cache stall
	ldd	[%src + offset + 0x10], %t2;	! 1 cycle, cache hit
	ldd	[%src + offset + 0x08], %t4;	! 1 cycle, cache hit
	st	%t0, [%dest + offset + 0x18];	! multi-cycle cache stall
	addxcc	%t0, %accum, %accum;		! 1 cycle, does not pair
	st	%t1, [%dest + offset + 0x1c];
	addxcc	%t1, %accum, %accum;		! 1 cycle, cache hit
	st	%t2, [%dest + offset + 0x10];
	addxcc	%t2, %accum, %accum;		! 1 cycle, cache hit
	ldd	[%src + offset + 0x00], %t0;	! 1 cycle, cache hit
	st	%t3, [%dest + offset + 0x14];	! 1 cycle, cache hit, cannot pair
	addxcc	%t3, %accum, %accum;
	st	%t4, [%dest + offset + 0x08];	! 1 cycle, cache hit
	addxcc	%t4, %accum, %accum;
	st	%t5, [%dest + offset + 0x0c];	! 1 cycle, cache hit
	addxcc	%t5, %accum, %accum;
	st	%t0, [%dest + offset + 0x00];	! 1 cycle, cache hit
	addxcc	%t0, %accum, %accum;
	st	%t1, [%dest + offset + 0x04];	! 1 cycle, cache hit
	addxcc	%t1, %accum, %accum;

						! around 19 clock cycles

Bite me, those stores make this stuff impossible to schedule without
grabbing a register window which I refuse to do.

Ok, on the MXCC you eat some cycles so that you have the registers
setup for the source (for the checksum calculations) and the page
numbers etc. for the stream operation for the entire chunk being
csum/copied.  Then it looks like this:

	st	%stream_addr1, [%stream_addr2] ASI_MXCC
	/* Processor stalls 3 or 4 clocks to get stream operation going. */

	ldd	[%src + offset + 0x18], %t0;	! cache hit
	addxcc	%t0, %accum, %accum;		! 1 cycle, does pair
	addxcc	%t1, %accum, %accum;		! 1 cycle, no pair
	ldd	[%src + offset + 0x10], %t2;	! cache hit
	addxcc	%t2, %accum, %accum;		! 1 cycle, does pair
	addxcc	%t3, %accum, %accum;		! 1 cycle, no pair
	ldd	[%src + offset + 0x08], %t4;	! cache hit
	addxcc	%t4, %accum, %accum;		! 1 cycle, cache hit
	addxcc	%t5, %accum, %accum;		! 1 cycle, no pair
	ldd	[%src + offset + 0x00], %t0;	! 1 cycle
	addxcc	%t0, %accum, %accum;		! 1 cycle, cache hit
	addxcc	%t1, %accum, %accum;		! 1 cycle, no pair

						! around 12 clock cycles

MXCC does all those ugly and hard to schedule stores for us ;-)  Note
that I could probably schedule that new sequence even better.

Saving of 7 clock cycles for _every_ 32 byte aligned block we csum,
the overhead of setting up for the stream operation is fuzzed away by
the fact that we usually run this thing many times in a row (thus the
"only do optimization  if len >= 256" rule above).

Let's assume in such an implementation that we eat around 13 or 14
cycles getting the registers ready for the stream operation.  Fine,
then after two straight iterations of the above code sequence we are
breaking even, we commonly run it many times in a row.

Common case for full ethernet frame is that we do 128 bytes at a shot,
11 times.  This works out to:

	(7 clocks saved per iteration * (128 / 32) * 11) -
	(14 stream-op setup cycles * 11 iterations)

	== 308 saved cycles - 154 lost cycles
	== 154 clocks less per csum on ethernet sized packet frame

Old code == 846 total cycles for ethernet sized packet frame
New code == 692 "" ""
	    
We go ~20% faster ;-)  A possible issue is overhead of function
ptr dereference for the call, but based upon the performance of our
dynamic mmu code I doubt it would matter and it would give gcc some
dead cycles to fill in the networking code anyways.

As noted previously, this would be a "research" venture to see what
kind of numbers it would really get.  Now that I think about it I
would be very leery about putting this into the tree so that we don't
hit the sun4d XBUS IOCACHE hardware bug (it is only triggered by MXCC
hardware block copy operations and certain types of dma activity with
a certain set of bit patterns in the data, nasty bug).

For now I'm re-scheduling the software csum/copy code to work as it
should (I was hitting the cache in the wrong way I've found from
Andy's numbers, fixing this right now).

Later,
David S. Miller
davem@caip.rutgers.edu
