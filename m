Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA27239 for <linux-archive@neteng.engr.sgi.com>; Mon, 20 Jul 1998 16:42:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA65100
	for linux-list;
	Mon, 20 Jul 1998 16:41:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA97837
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 20 Jul 1998 16:41:30 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA29636
	for <linux@cthulhu.engr.sgi.com>; Mon, 20 Jul 1998 16:41:28 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-26.uni-koblenz.de [141.26.249.26])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA06866
	for <linux@cthulhu.engr.sgi.com>; Tue, 21 Jul 1998 01:41:25 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA01452;
	Tue, 21 Jul 1998 01:41:19 +0200
Message-ID: <19980721014118.A1196@uni-koblenz.de>
Date: Tue, 21 Jul 1998 01:41:18 +0200
To: Ulf Carlsson <grimsy@zigzegv.ml.org>, linux@cthulhu.engr.sgi.com
Subject: Re: cross compiler fix
References: <Pine.LNX.3.96.980719205718.21761B-100000@morpho.dar.net> <Pine.LNX.3.96.980720203318.12940D-101000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.96.980720203318.12940D-101000@calypso.saturn>; from Ulf Carlsson on Mon, Jul 20, 1998 at 08:40:59PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jul 20, 1998 at 08:40:59PM +0200, Ulf Carlsson wrote:

> Ralf has done some changes in the kernel tree for the egcs compiler (as
> far as I understand it). So, here's a fix for the crosscompiler, a
> modified specs file (/usr/local/lib/gcc-lib/mips-linux/2.7.2.2/specs).
> 
> Thank Ralf, not me - he told me what to change.

Ok, now that Ulf already posted the patch to the spec file, let me explain
the problem.  The usual C compilers for MIPS systems define a C preprocessor
macro based on the language of the input file.  These macros have names
like LANGUAGE_C or LANGUAGE_ASSEMBLER.  Usually several variations are
being defined with no, one or two heading underscores, sometimes even
trailing underscores.  The Linux/MIPS compiler handled this different.
As the result the definitions which were expected by the kernel headers,
were not available.

While it would have been easy to fix the kernel to compile with either
gcc 2.7.2 or egcs I don't intend it makes much sense to carry this historic
garbage with us.  So I just fixed it to compile with egcs.

Now brewing crosscompilers has historically proven to be a tough problem
for many user, so the hacked Spec file posted by Ulf can take away this
pain for crosscompiler users.

  Ralf
