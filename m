Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA56576 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Oct 1998 19:54:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA84242
	for linux-list;
	Thu, 15 Oct 1998 19:53:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA27598
	for <linux@engr.sgi.com>;
	Thu, 15 Oct 1998 19:53:53 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA05326
	for <linux@engr.sgi.com>; Thu, 15 Oct 1998 19:53:51 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-21.uni-koblenz.de [141.26.249.21])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id EAA24226
	for <linux@engr.sgi.com>; Fri, 16 Oct 1998 04:53:46 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id BAA01719;
	Thu, 15 Oct 1998 01:49:55 +0200
Message-ID: <19981015014955.K392@uni-koblenz.de>
Date: Thu, 15 Oct 1998 01:49:55 +0200
From: ralf@uni-koblenz.de
To: Rik van Riel <H.H.vanRiel@phys.uu.nl>
Cc: Vladimir Roganov <roganov@niisi.msk.ru>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, linux-mips@vger.rutgers.edu,
        linux-kernel@vger.rutgers.edu
Subject: Re: get_mmu_context()
References: <19981013215927.A2692@uni-koblenz.de> <Pine.LNX.3.96.981014144230.10483B-100000@mirkwood.dummy.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.96.981014144230.10483B-100000@mirkwood.dummy.home>; from Rik van Riel on Wed, Oct 14, 1998 at 02:45:45PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Oct 14, 1998 at 02:45:45PM +0000, Rik van Riel wrote:

> > Ok, here is a draft version of an agressively optimized version of
> > get_mmu_context().  I just didn't like the idea of referencing
> > global variables in get_mmu_context() if avoidable.  The code below
> > will work on both R3000 and R4000 with no performance penalty for
> > being generic.  The trick is to patch the operands of two machine
> > instructions at runtime, shoot me.
> 
> ROFL! No offense to the code, I'm sure it works, but
> this just _has_ to be the funniest piece of source
> code to appear on the lists this month...
> 
> Self-modifying code -- this is so much fun :)

Lame example of self modifying code, it doesn't even modify the instructions
and only on bootup.

> > extern inline void r3000_asid_setup(void)
> > 
> > extern inline void r4xx0_asid_setup(void)
> 
> Very nice Ralf... My compliments on this piece
> of code -- I can only imagine the amount of
> phantasy and inspiration that was needed to
> create it...

Guess why I had to post it :-)  Seriously, I didn't like the proposed
alternative and some of the older machines which have main memory latencies
like 1400ns for shure win each time when _not_ using memory.  Even in
case of a l1 hit the amount of time wasted for the load should still be
visible in context switching times.  So, no mercy.  Patch as patch can.
And maintenance isn't the issue.  I messed it up, I maintain it :-)

  Ralf
