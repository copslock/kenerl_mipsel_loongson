Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA18489; Mon, 24 Jun 1996 05:25:26 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA04132 for linux-list; Mon, 24 Jun 1996 12:25:19 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA04127 for <linux@cthulhu.engr.sgi.com>; Mon, 24 Jun 1996 05:25:18 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA18480; Mon, 24 Jun 1996 05:25:17 -0700
Date: Mon, 24 Jun 1996 05:25:17 -0700
Message-Id: <199606241225.FAA18480@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: R4k taglo/taghi hardware bugs^H^H^H^Hfeatures?
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Are there any known problems with the taglo/taghi registers showing
what they should after "indexed load tag secondary" cache
instructions?  Whatever is in both registers before the cache
instruction, is still in there afterwards...  I've also tried the
primary-data and primary-instruction variants of the cache operations
and still same results.

I don't know, but it is so nice how the primary cache sizes are stored
in well defined config registers in CP0, yet the secondary cache needs
to be sized by complete magic and diagnostic mechanisms.  The CPU
knows the size of the secondary cache lines, why so difficult to put
the secondary cache total size somewhere similar?  (for those of you
playing at home, yes I know the R5k Triton does this in the CP0 config
register, but all other R4k variants do not)

I've been up all night trying to figure out what (isn't) happening...

Later,
David S. Miller
dm@sgi.com
