Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA2837348 for <linux-archive@neteng.engr.sgi.com>; Fri, 3 Apr 1998 13:03:57 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id NAA7514889
	for linux-list;
	Fri, 3 Apr 1998 13:03:03 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA7063818;
	Fri, 3 Apr 1998 13:02:58 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id NAA08995; Fri, 3 Apr 1998 13:02:54 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-16.uni-koblenz.de [141.26.249.16])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id XAA28992;
	Fri, 3 Apr 1998 23:02:42 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA05294;
	Fri, 3 Apr 1998 23:02:32 +0200
Message-ID: <19980403230230.64621@uni-koblenz.de>
Date: Fri, 3 Apr 1998 23:02:30 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "William J. Earl" <wje@fir.engr.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: VCE exceptions
References: <199804031911.LAA21028@fir.engr.sgi.com> <m0yLByA-000aNnC@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <m0yLByA-000aNnC@the-village.bc.nu>; from Alan Cox on Fri, Apr 03, 1998 at 08:17:41PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Apr 03, 1998 at 08:17:41PM +0100, Alan Cox wrote:

> >      As soon as I get a chance, I will look at the relevant linux
> > code.  Note that physical color allocation can also make a big
> > performance difference on direct mapped secondary caches, as on all of
> 
> Colouring in Linux isnt going to work without ripping the godawful buddy
> allocator out of it. Unfortunately Linus seems quite attached to it at
> the moment. Bamboo under the finger nails at Linux Expo perhaps Ralph ?

That alone would be worth the price of the ticket.

> Whenever we try and do any colouring it fragments the buddy stuff up 
> sufficiently badly that we basically break the box. 

Has anybody already played with a kind of ``colour caches''?  I'm thinking
of creating a cache of a couple of free pages per colour that is similarly
related to the buddy system as the slab is currently, just for pages of
certain colours.  That would still by kludgy, but Linus might like it ;-)

  Ralf  (Still not Ralph :-)
