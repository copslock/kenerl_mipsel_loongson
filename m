Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA70348 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Jun 1998 17:19:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA89319
	for linux-list;
	Mon, 8 Jun 1998 17:17:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from dragon.engr.sgi.com (dragon.engr.sgi.com [150.166.105.14])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA15942
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 8 Jun 1998 17:17:11 -0700 (PDT)
	mail_from (sr@dragon.engr.sgi.com)
Received: (from sr@localhost) by dragon.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id RAA20363 for linux@engr.sgi.com; Mon, 8 Jun 1998 17:17:11 -0700 (PDT)
From: sr@dragon.engr.sgi.com (Steve Rikli)
Message-Id: <199806090017.RAA20363@dragon.engr.sgi.com>
Subject: Re: Some questions...
To: linux@cthulhu.engr.sgi.com
Date: Mon, 8 Jun 1998 17:17:11 -0700 (PDT)
In-Reply-To: <19980608081402.10078@uni-koblenz.de> from "ralf@uni-koblenz.de" at Jun 8, 98 08:14:02 am
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de wrote:
> On Sat, Jun 06, 1998 at 08:32:49AM +0200, Peter Maydell wrote:
> 
> > Ariel Faigon wrote:
> > >	1) If you have the Indy (hardware) you already have
> > >	   the license for IRIX (for your own use)
> > 
> > Does this hold for earlier machines as well? I have a 4D/70GT with no
> > system software... 
> > 
> > While I'm here, I thought I'd look into the feasibility of porting
> > Linux to this machine. [In fact, I'm probably not going to have access
> > to the machine for long enough to work on it, but maybe somebody else
> > will. (the machine belongs to the Computer Preservation Society here in
> > Cambridge...)]
> > 
> > Anyway, points that spring to mind:
> > * the CPU is an R2000; I don't think any of the current ports are for
> > less than an R3000 -- does anybody know how different the R2000 is?
> 
> The R3000 is basically an R2000 which has undergone an overhaul to make
> higher clockrate possible.  With respect to software R2000 and R3000 are
> 100% compatible with the exception that the product ID register c0_prid
> contains a different value.
> 
> For those of you who are not reading linux-mips@fnet.fr, Harald yesterday
> managed to bring his DECstation into userland booting from a ramdisk, so a
> large fraction of the job has been done.
> 
> > * without hardware documentation I suspect it will be impossible to get
> > anywhere. Every board seems to have a CPU on it :-> The ESDI and ethernet
> > boards both have 68000s, and the graphics board set has a 68020 complete
> > with debugging monitor you can access via a serial terminal, in addition
> > to all those custom chips...
> > Are SGI being helpful about providing documentation on the older hardware?
> 
> This is one point.  The other is as somebody else mentioned in this thread
> that few people actually still have such a machine, the number of active
> kernel hackers will be even lower.  Given that and that the machine is
> unsupported since a long time, maybe SGI might even consider contributing
> sources for such ancient systems as long as they're not poisoned with AT&T
> (C) stuff ...

This might be an opportune time to point out the "This Old SGI" website
again:

	http://www.geocities.com/SiliconValley/Pines/2258/4dfaq.html

I dunno how helpful the info therein will be wrt Linux porting, but from
a purely selfish point of view I'd love to see Linux running on the 4D
(especially MP boxes like 4D/440 et al) series & other R3K boxes (e.g.
classic Indigo) since I personally own a couple of them.  ;)

cheers,
sr.
-- 
|| Steve Rikli <sr@sgi.com> |||                                         ||
|| Systems Administrator    ||| How can something that is almost 3 MB   ||
|| SNS, EIS Infrastructure  ||| in size be called a "kernel"?           ||
|| Silicon Graphics, Inc.   |||                                         ||
