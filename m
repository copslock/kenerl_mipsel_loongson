Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA09331 for <linux-archive@neteng.engr.sgi.com>; Sun, 12 Jul 1998 17:37:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA21035
	for linux-list;
	Sun, 12 Jul 1998 17:36:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA44557
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 12 Jul 1998 17:36:48 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA03453
	for <linux@cthulhu.engr.sgi.com>; Sun, 12 Jul 1998 17:36:47 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-25.uni-koblenz.de [141.26.249.25])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA21285
	for <linux@cthulhu.engr.sgi.com>; Mon, 13 Jul 1998 02:36:44 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA18524;
	Mon, 13 Jul 1998 02:36:08 +0200
Message-ID: <19980713023606.U10756@uni-koblenz.de>
Date: Mon, 13 Jul 1998 02:36:06 +0200
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: One good and some bad news
References: <19980712112949.25350@alpha.franken.de> <19980712190135.R10756@uni-koblenz.de> <19980712235319.65470@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980712235319.65470@alpha.franken.de>; from Thomas Bogendoerfer on Sun, Jul 12, 1998 at 11:53:19PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jul 12, 1998 at 11:53:19PM +0200, Thomas Bogendoerfer wrote:

> no, that's the one I've built:-) But it's made with your XFree patch
> and an updated .spec file for the latest RH5.1 package (XFree86-3.3.2-13).
> A couple of hours ago, I had X with window manager and application running
> (PS/2 mouse works, too). There is only one small problem left, when scrolling
> the X screen down. Looks like my "hardware" scrolling has some problems
> with graphics.

Cool.

> > DBE has a nasty property, it can be delayed until some write access
> > is written back from cache to memory.  The EPC then often points to
> > completly useless addresses.
> 
> good to know, as the address was really bogus. Is there a chance to
> print out the faulting physical address for a bus error ? This would
> give us some chances to find the real culprit. But it still hasn't happen
> again.

Basically what to do would be to modify the kernel such that it will work
with caches disabled.  Then you get (almost) precise exceptions again.
Alternative and with less impact on the performance you could try to
writeback the caches in strategic positions for debugging.  That makes a
kind of a barrier for DBE exceptions.

> hmm, I've checked the MAP_NR() in the kernel, and couldn't find such
> cases. In fact my changed kernel works perfect.

Good.  Long time ago we had such cases in the kernel; it's why MAP_NR
does things the way it does.  But I admit, when I wrote my last posting
I could recall what I needed that stuff for.

You patch looks good, could you commit it?  Thanks.

> > These type of warning messae often indicate serious trouble.
> 
> hmm, the produced binaries are working without problem.

Hmmm ...  Modify write(2) to not print these messages ;-)

  Ralf
