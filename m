Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id MAA460724 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Dec 1997 12:53:52 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA17202 for linux-list; Mon, 22 Dec 1997 12:46:10 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA17184 for <linux@cthulhu.engr.sgi.com>; Mon, 22 Dec 1997 12:46:08 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA20996
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Dec 1997 12:46:03 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id VAA03830;
	Mon, 22 Dec 1997 21:45:26 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id VAA15307; Mon, 22 Dec 1997 21:45:24 +0100
Message-ID: <19971222214524.32302@thoma.uni-koblenz.de>
Date: Mon, 22 Dec 1997 21:45:24 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Mike Shaver <shaver@netscape.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: flush_cache_all() hoses my Indy
References: <349E2FCF.605C2665@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <349E2FCF.605C2665@netscape.com>; from Mike Shaver on Mon, Dec 22, 1997 at 01:15:59AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Dec 22, 1997 at 01:15:59AM -0800, Mike Shaver wrote:
> OK, I've been tracking a bug that only seems to appear on the Indy I
> have at home right now (belongs to the housemates).  After sgiseeq_init
> allocates the ring buffers, it calls flush_cache_all().  On this system,
> that zeroes out the ring buffer pointers (rx and tx -- likely the entire
> dev->priv block and more) and then setup_tx_ring gets understandably
> upset. =)
> 
> Anyway, I'm not enough of a MIPS guru to really say much more, but I'll
> poke around tonight and see if I can stumble across anything useful.
> 
> Linux reports:
> MIPS 4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE

There is a bug in the l2 flushing for theSC/MC versions, it uses the
wrong cacheops.  I've fixed it in my home tree.

  Ralf
