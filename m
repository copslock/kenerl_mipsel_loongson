Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA02158 for <linux-archive@neteng.engr.sgi.com>; Mon, 6 Jul 1998 11:33:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA35149
	for linux-list;
	Mon, 6 Jul 1998 11:32:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA04123
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Jul 1998 11:32:05 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA10399
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Jul 1998 11:32:01 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from uhland (ralf@uhland.uni-koblenz.de [141.26.4.63])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id UAA10856;
	Mon, 6 Jul 1998 20:31:56 +0200 (MEST)
Received: by uhland (SMI-8.6/KO-2.0)
	id UAA06464; Mon, 6 Jul 1998 20:31:54 +0200
Message-ID: <19980706203153.03930@uni-koblenz.de>
Date: Mon, 6 Jul 1998 20:31:53 +0200
From: ralf@uni-koblenz.de
To: Mike Shaver <shaver@netscape.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: mozilla on the Indy
References: <359A447B.2D25377D@netscape.com> <19980702041137.I3255@uni-koblenz.de> <35A10B96.9B47C150@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <35A10B96.9B47C150@netscape.com>; from Mike Shaver on Mon, Jul 06, 1998 at 01:38:30PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jul 06, 1998 at 01:38:30PM -0400, Mike Shaver wrote:

> ralf@uni-koblenz.de wrote:
> > Now that I've taken myself two minutes to browse your attached sources -
> > the patches to the NSPR thread routines look suspicious.  The are
> > playing games with the frame pointer which at least on the first look
> > don't make sense as gcc automatically enables -fomit-frame-pointer when
> > optimizing.
> 
> Turns out it's there only to save the FP so that you can use gdb to look
> at the NSPR thread stacks during debugging.  So, the fact that gcc
> removes it when building optimized isn't a problem.
> 
> For the record, NSPR threads aren't clone() threads; they're
> setjmp/longjmp things.

Usless effort, on MIPS debugging works without having a frame pointer.

  RalF
