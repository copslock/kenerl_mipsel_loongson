Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA86554 for <linux-archive@neteng.engr.sgi.com>; Thu, 9 Jul 1998 09:08:58 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA00262
	for linux-list;
	Thu, 9 Jul 1998 09:07:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA74836
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Jul 1998 09:07:51 -0700 (PDT)
	mail_from (grimsy@zigzegv.ml.org)
Received: from ballyhoo.ml.org ([194.236.80.80]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA17891
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Jul 1998 09:07:47 -0700 (PDT)
	mail_from (grimsy@zigzegv.ml.org)
Received: from calypso.saturn ([130.244.94.56]) by ballyhoo.ml.org
	 with smtp (ident grimsy using rfc1413) id m0yuJBm-000xhRC
	(Debian Smail-3.2.0.92 1997-Feb-9 #2); Thu, 9 Jul 1998 18:04:54 +0200 (CEST)
Date: Thu, 9 Jul 1998 18:06:18 +0200 (CEST)
From: Ulf Carlsson <grimsy@zigzegv.ml.org>
X-Sender: grimsy@calypso.saturn
To: ralf@uni-koblenz.de
cc: Honza Pazdziora <adelton@informatics.muni.cz>, linux@cthulhu.engr.sgi.com
Subject: Re: Lmbench for RH 5.1
In-Reply-To: <19980709155330.61627@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980709180404.368B-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, 9 Jul 1998 ralf@uni-koblenz.de wrote:

> On Thu, Jul 09, 1998 at 03:47:13PM +0200, Honza Pazdziora wrote:
> 
> > > The question what is trying to use autoconf.h for what reason remains;
> > > user code isn't supposed to use this file.
> > 
> > Hmm, I got the default kernel from kernel/v2.1 and just unpacked it to
> > get the others *.h files (linux and asm). I do not have the SGI kernel
> > -- it is somewhere available? Alex said he will pack the sources as
> > RPM with configuration but I cannot find it on linus' ftp -- is it
> > somewhere there?
> 
> Of course it is available, this is free software!  Snapshots from our CVS
> and binaries are in /pub/test/; I think we currently only have them as
> tarballs, not in rpm format.  You can also access the CVS directly by
> using anonymous CVS.

The kernel source is availible in RPM format in
/pub/redhat/devel/RPMS/kernel-headers-2.1.99-0.1.mipseb.rpm
/pub/redhat/devel/RPMS/kernel-source-2.1.99-0.1.mipseb.rpm

I think kernel-headers-2.1.99-0.1.mipseb.rpm would be enough for your
needs. I have used this kernel source and it compiles fine with the gcc
cross compiler for x86.

FYI

- Ulf
