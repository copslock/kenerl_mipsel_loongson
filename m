Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA51935 for <linux-archive@neteng.engr.sgi.com>; Thu, 9 Jul 1998 06:54:07 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA91317
	for linux-list;
	Thu, 9 Jul 1998 06:53:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA22255
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Jul 1998 06:53:35 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA29565
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Jul 1998 06:53:34 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id PAA04844;
	Thu, 9 Jul 1998 15:53:32 +0200 (MEST)
Received: by zaphod (SMI-8.6/KO-2.0)
	id PAA29810; Thu, 9 Jul 1998 15:53:30 +0200
Message-ID: <19980709155330.61627@uni-koblenz.de>
Date: Thu, 9 Jul 1998 15:53:30 +0200
From: ralf@uni-koblenz.de
To: Honza Pazdziora <adelton@informatics.muni.cz>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Lmbench for RH 5.1
References: <19980709153920.50904@uni-koblenz.de> <199807091347.PAA03503@aisa.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <199807091347.PAA03503@aisa.fi.muni.cz>; from Honza Pazdziora on Thu, Jul 09, 1998 at 03:47:13PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Jul 09, 1998 at 03:47:13PM +0200, Honza Pazdziora wrote:

> > The question what is trying to use autoconf.h for what reason remains;
> > user code isn't supposed to use this file.
> 
> Hmm, I got the default kernel from kernel/v2.1 and just unpacked it to
> get the others *.h files (linux and asm). I do not have the SGI kernel
> -- it is somewhere available? Alex said he will pack the sources as
> RPM with configuration but I cannot find it on linus' ftp -- is it
> somewhere there?

Of course it is available, this is free software!  Snapshots from our CVS
and binaries are in /pub/test/; I think we currently only have them as
tarballs, not in rpm format.  You can also access the CVS directly by
using anonymous CVS.

  Ralf
