Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA37592 for <linux-archive@neteng.engr.sgi.com>; Thu, 8 Oct 1998 13:33:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA78988
	for linux-list;
	Thu, 8 Oct 1998 13:31:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id NAA36707;
	Thu, 8 Oct 1998 13:31:47 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id NAA04597; Thu, 8 Oct 1998 13:30:36 -0700
Date: Thu, 8 Oct 1998 13:30:36 -0700
Message-Id: <199810082030.NAA04597@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: ralf@uni-koblenz.de, linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Subject: Re: Tags are dead alias Milo is dead part II
In-Reply-To: <19981008215834.51243@alpha.franken.de>
References: <19981007002547.44731@alpha.franken.de>
	<19981008170335.H4058@uni-koblenz.de>
	<19981008215834.51243@alpha.franken.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thomas Bogendoerfer writes:
 > On Thu, Oct 08, 1998 at 05:03:35PM +0200, ralf@uni-koblenz.de wrote:
 > > Applied to the G364 drivers (which as of now is still MIPS specific anyway)
 > > this means that we'll avoid TLB trashing in the case of scrolling and have
 > > the full TLB available for userland.
 > 
 > I don't believe this will buy us anything. When we add a temporary TLB we need
 > do clear one TLB, which might be used by the userland. So we end up loading
 > our wired entry, killing it, and later the user process has to reload the 
 > TLB again. This way we force TLB trashing, with one wired entry more we
 > _might_ get a little bit more TLB trashing.
 > 
 > As you might know, I'm using three wired entries for the Magnum, and I don't 
 > think doing the same trick for the other entries is a real good idea. When 
 > we make them temporary, we have to mess with TLBs on every interrupt.

     You could do what IRIX does in some cases, which is to save and restore
the TLB entry you replace.  Beware of doing this, however, if your code could
take a page fault.
