Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA69474 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Jun 1998 17:04:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA38983
	for linux-list;
	Mon, 8 Jun 1998 17:02:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA52136
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 8 Jun 1998 17:02:38 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id RAA21082
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Jun 1998 17:02:36 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-24.uni-koblenz.de [141.26.249.24])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA12903
	for <linux@cthulhu.engr.sgi.com>; Tue, 9 Jun 1998 02:02:33 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id IAA01021;
	Mon, 8 Jun 1998 08:14:02 +0200
Message-ID: <19980608081402.10078@uni-koblenz.de>
Date: Mon, 8 Jun 1998 08:14:02 +0200
To: Peter Maydell <pm215@cam.ac.uk>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Some questions...
References: <199806060025.RAA47789@oz.engr.sgi.com> <E0yiDT9-0005f5-00@mnementh.trin.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <E0yiDT9-0005f5-00@mnementh.trin.cam.ac.uk>; from Peter Maydell on Sat, Jun 06, 1998 at 08:32:49AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Jun 06, 1998 at 08:32:49AM +0200, Peter Maydell wrote:

> Ariel Faigon wrote:
> >	1) If you have the Indy (hardware) you already have
> >	   the license for IRIX (for your own use)
> 
> Does this hold for earlier machines as well? I have a 4D/70GT with no
> system software... 
> 
> While I'm here, I thought I'd look into the feasibility of porting
> Linux to this machine. [In fact, I'm probably not going to have access
> to the machine for long enough to work on it, but maybe somebody else
> will. (the machine belongs to the Computer Preservation Society here in
> Cambridge...)]
> 
> Anyway, points that spring to mind:
> * the CPU is an R2000; I don't think any of the current ports are for
> less than an R3000 -- does anybody know how different the R2000 is?

The R3000 is basically an R2000 which has undergone an overhaul to make
higher clockrate possible.  With respect to software R2000 and R3000 are
100% compatible with the exception that the product ID register c0_prid
contains a different value.

For those of you who are not reading linux-mips@fnet.fr, Harald yesterday
managed to bring his DECstation into userland booting from a ramdisk, so a
large fraction of the job has been done.

> * without hardware documentation I suspect it will be impossible to get
> anywhere. Every board seems to have a CPU on it :-> The ESDI and ethernet
> boards both have 68000s, and the graphics board set has a 68020 complete
> with debugging monitor you can access via a serial terminal, in addition
> to all those custom chips...
> Are SGI being helpful about providing documentation on the older hardware?

This is one point.  The other is as somebody else mentioned in this thread
that few people actually still have such a machine, the number of active
kernel hackers will be even lower.  Given that and that the machine is
unsupported since a long time, maybe SGI might even consider contributing
sources for such ancient systems as long as they're not poisoned with AT&T
(C) stuff ...

  Ralf
