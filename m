Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA80158 for <linux-archive@neteng.engr.sgi.com>; Wed, 15 Jul 1998 14:59:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA58158
	for linux-list;
	Wed, 15 Jul 1998 14:58:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA04379
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 15 Jul 1998 14:58:37 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA27170
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Jul 1998 14:58:35 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (root@pmport-25.uni-koblenz.de [141.26.249.25])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id XAA06438
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Jul 1998 23:58:27 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id RAA00625;
	Wed, 15 Jul 1998 17:26:02 +0200
Message-ID: <19980715172602.A388@uni-koblenz.de>
Date: Wed, 15 Jul 1998 17:26:02 +0200
To: Honza Pazdziora <adelton@informatics.muni.cz>,
        Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: The pre-release of Hard Hat Linux for SGI...
References: <Pine.LNX.3.95.980715015327.30234B-100000@lager.engsoc.carleton.ca> <199807150900.LAA00705@aisa.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199807150900.LAA00705@aisa.fi.muni.cz>; from Honza Pazdziora on Wed, Jul 15, 1998 at 11:00:47AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jul 15, 1998 at 11:00:47AM +0200, Honza Pazdziora wrote:

> Yes, I'll try to create the page. Basically R4400, R4600, R5000,
> PC and SC, anyrate are OK? How about R4000? Other hardware: XGE, XZ
> (for consoles), 10BaseT, any reasonable SCSI? How about the Challenge S?

10BaseT - never tested. I use 10Base2 but I assume the mediaselection works
properly.

XGE, XZ graphics are not supported yet.  We might however try to use the
ARC firmware to support anything that we don't support yet as a console.

We only support the the builtin WD33C93 hostadapter.  Extra GIO boards,
especially the WD33C95 (afaik available in the Challenge S), are not
supported yet.

Challenge S isn't supported yet.

The cache issues seems to be confusing to many people, so here a simple
explanation of the issue.  The actual issues are a bit more complex
especially in the case of R4000SC, R4000MC, R4400SC, R4400MC.

Processor types: R4000PC / R4400PC, R4600, R5000.  We've got support for
the second level cache as available on the R4600 and R5000 CPU _boards_,
known as R4600SC and R5000SC.  We do not support the CPU controlled
cache as in R4000SC, R4400SC and R5000.

Why does the second level cache make a difference?  The second level
cache on MIPS systems is ``visible'' to software and the kernel needs
appropriate support for each of them.  We do have this support code for
the external cache controllers on the Indy R4600 and R5000 modules.

R4000SC, R4000MC, R4400SC, R4400MC have integrated cache controllers
which we don't support.  The R5000 also has one which we don't support.
However the Indy R5000SC modules use an external cache controller and
that one is supported.

There are more MIPS CPU types that we support - some of them even
don't exist yet as silicon - but these types were never shipped in Indys.

  Ralf
