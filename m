Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA23805; Thu, 16 May 1996 21:01:18 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA14641 for linux-list; Fri, 17 May 1996 04:01:14 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA14636 for <linux@cthulhu.engr.sgi.com>; Thu, 16 May 1996 21:01:12 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA23798 for <lmlinux@neteng.engr.sgi.com>; Thu, 16 May 1996 21:01:11 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA14628; Thu, 16 May 1996 21:01:10 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id VAA25665; Thu, 16 May 1996 21:01:08 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id AAA20410; Fri, 17 May 1996 00:01:06 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id AAA19770; Fri, 17 May 1996 00:01:05 -0400
Date: Fri, 17 May 1996 00:01:05 -0400
Message-Id: <199605170401.AAA19770@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: lm@gate1-neteng.engr.sgi.com
CC: lmlinux@neteng.engr.sgi.com, torvalds@cs.helsinki.fi,
        sparclinux-cvs@caipfs.rutgers.edu, alan@cymru.net
In-reply-to: <199605161603.JAA03193@neteng.engr.sgi.com>
	(lm@gate1-neteng.engr.sgi.com)
Subject: Re: lmbench with new checksum code...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
   Date: Thu, 16 May 1996 09:03:36 -0700

   I think your 4.8MB/sec number is pretty studly.  That means you are 
   checksumming 9MB/sec as well as the protocol stack on a system that 
   bcopies at ~20MB/sec.  You're already better than 2x the SunOS code.
   Call it a day, you won.

I did not win, this is unacceptable.  I am completely convinced based
upon the edge I have over Solaris for context switching and general
process/trap operations I should be able to match it even with
everything going through real networking.

Linux + full networking overhead == Solaris memcpy/cow-page overhead

I cannot accept this piss poor performance I'm getting, it must be
made faster.

(Yes, I'm rediculious, Larry will tell you others how I feel that if
 I am presented with a "next generation" cpu and I cannot get from
 trap entry to kernel c-code in 12 completely pipelined non-stalling
 instructions then some hardware engineer has completely wasted his
 precious time ;-)

Later,
David S. Miller
davem@caip.rutgers.edu
