Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA808961 for <linux-archive@neteng.engr.sgi.com>; Mon, 17 Nov 1997 15:31:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA05650 for linux-list; Mon, 17 Nov 1997 15:29:19 -0800
Received: from hollywood.engr.sgi.com (hollywood.engr.sgi.com [150.166.61.38]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA05624 for <linux@cthulhu.engr.sgi.com>; Mon, 17 Nov 1997 15:29:17 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by hollywood.engr.sgi.com (940816.SGI.8.6.9/960327.SGI.AUTOCF) via ESMTP id PAA04987; Mon, 17 Nov 1997 15:29:17 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA05492; Mon, 17 Nov 1997 15:29:00 -0800
Received: from dm.cobaltmicro.com ([209.19.61.51]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA24035; Mon, 17 Nov 1997 15:28:59 -0800
	env-from (davem@dm.cobaltmicro.com)
Received: (from davem@localhost)
	by dm.cobaltmicro.com (8.8.7/8.8.7) id PAA27334;
	Mon, 17 Nov 1997 15:23:46 -0800
Date: Mon, 17 Nov 1997 15:23:46 -0800
Message-Id: <199711172323.PAA27334@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: fisher@sgi.com
CC: linux@hollywood.engr.sgi.com, fisher@hollywood.engr.sgi.com
In-reply-to: <199711172128.NAA04775@hollywood.engr.sgi.com>
	(fisher@hollywood.engr.sgi.com)
Subject: Re: Pentium F00F bug Linux workaround; BSDI Response
References:  <199711172128.NAA04775@hollywood.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I'm going to choose more lightly what I decide to post here if it's
going to make it's way to every tom, dick, and harry out there in the
unix industry...

Fact is that Intel was trying to make sure _no_ vendor had a fix out
before anyone else.  If it was not explicitly stated in the NDA they
signed with Intel, this was a mistake and not what was intended.

Now that you've talked to Borman about this fish, ask him why he had
to take the patch set down within a day or so.  If he says "because it
was a BETA patch set", I'd find his response hard to believe.

Intel engineers internally were working themselves on fixes for
various systems that they did have source to (Linux, maybe
{net,free}BSD and a few others) and planned to release those patch
sets and allow vendors to release their own patches at the same exact
time.

BSDI putting out their patch ahead of that point in time was, if
anything, totally against how Intel wanted things happen.

Later,
David S. Miller
davem@dm.cobaltmicro.com
