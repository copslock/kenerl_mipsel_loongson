Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA23169; Fri, 2 May 1997 05:15:50 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA12156 for linux-list; Fri, 2 May 1997 05:15:51 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA12133 for <linux@engr.sgi.com>; Fri, 2 May 1997 05:15:48 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id FAA20461
	for <linux@engr.sgi.com>; Fri, 2 May 1997 05:15:38 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from ozzy (ralf@ozzy.uni-koblenz.de [141.26.5.8]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id OAA13307; Fri, 2 May 1997 14:11:10 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199705021211.OAA13307@informatik.uni-koblenz.de>
Received: by ozzy (SMI-8.6/KO-2.0)
	id OAA03035; Fri, 2 May 1997 14:11:07 +0200
Subject: Re: linux-2.1.36
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Fri, 2 May 1997 14:11:06 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com, davem@caip.rutgers.edu
In-Reply-To: <199705021121.HAA22284@neon.ingenia.ca> from "Mike Shaver" at May 2, 97 07:21:17 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> Looks like sgiserial.c needs to be updated to use the new IRQ stuff,
> etc. (can't find keypress_wait, still using queue_task_irq_off).

Mea culpa.  I leave that part to you.

> I'm going to wish I was paying more attention on linux-kernel when
> people were going over this stuff, I just know it. =)
> 
> Also, wd33c93.c fails to compile.  Probably some simple stuff (I'm
> getting parse errors), but I won't be able to do much with it until
> the afternoon.

I messed the wd driver stuff up.  I didn't fix the rejects when applying
Linus' patch 2.1.36.  I fixed that in the meantime and will try to find
time to make a pre-patch-2.1.37 before I leave Germany.

David did completly reformat the WD driver to make it readable.  Downside
is that it's difficult to see what he really has changed.  Someone
should probably do that.

David, what are the differences between your version of the WD driver
and the stock WD driver?

  Ralf
