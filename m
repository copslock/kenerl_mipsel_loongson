Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA36599 for <linux-archive@neteng.engr.sgi.com>; Thu, 8 Oct 1998 13:03:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA52464
	for linux-list;
	Thu, 8 Oct 1998 13:02:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA81279
	for <linux@engr.sgi.com>;
	Thu, 8 Oct 1998 13:02:11 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA08904
	for <linux@engr.sgi.com>; Thu, 8 Oct 1998 13:02:08 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zRMG8-0027xGC@rachael.franken.de>
	for engr.sgi.com!linux; Thu, 8 Oct 1998 21:02:00 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zRMG1-002P9YC; Thu, 8 Oct 98 22:01 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA03189;
	Thu, 8 Oct 1998 21:58:35 +0200
Message-ID: <19981008215834.51243@alpha.franken.de>
Date: Thu, 8 Oct 1998 21:58:34 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Subject: Re: Tags are dead alias Milo is dead part II
References: <19981007002547.44731@alpha.franken.de> <19981008170335.H4058@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19981008170335.H4058@uni-koblenz.de>; from ralf@uni-koblenz.de on Thu, Oct 08, 1998 at 05:03:35PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Oct 08, 1998 at 05:03:35PM +0200, ralf@uni-koblenz.de wrote:
> Applied to the G364 drivers (which as of now is still MIPS specific anyway)
> this means that we'll avoid TLB trashing in the case of scrolling and have
> the full TLB available for userland.

I don't believe this will buy us anything. When we add a temporary TLB we need
do clear one TLB, which might be used by the userland. So we end up loading
our wired entry, killing it, and later the user process has to reload the 
TLB again. This way we force TLB trashing, with one wired entry more we
_might_ get a little bit more TLB trashing.

As you might know, I'm using three wired entries for the Magnum, and I don't 
think doing the same trick for the other entries is a real good idea. When 
we make them temporary, we have to mess with TLBs on every interrupt.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
