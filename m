Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA90419 for <linux-archive@neteng.engr.sgi.com>; Thu, 9 Jul 1998 06:47:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA03712
	for linux-list;
	Thu, 9 Jul 1998 06:47:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA48305
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Jul 1998 06:47:20 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA27522
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Jul 1998 06:47:17 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id PAA10899;
	Thu, 9 Jul 1998 15:47:14 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id PAA15199;
	Thu, 9 Jul 1998 15:47:14 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id PAA03503;
	Thu, 9 Jul 1998 15:47:13 +0200 (MET DST)
Message-Id: <199807091347.PAA03503@aisa.fi.muni.cz>
Subject: Re: Lmbench for RH 5.1
In-Reply-To: <19980709153920.50904@uni-koblenz.de> from "ralf@uni-koblenz.de" at "Jul 9, 98 03:39:20 pm"
To: ralf@uni-koblenz.de
Date: Thu, 9 Jul 1998 15:47:13 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> > The version 2beta6 of lmbench complains about missing
> > linux/autoconf.h.
> 
> You probably ran make distclean on the kernel source tree?  Don't, best
> leave the kernel source tree configured around, so just use make clean.
> 
> The question what is trying to use autoconf.h for what reason remains;
> user code isn't supposed to use this file.

Hmm, I got the default kernel from kernel/v2.1 and just unpacked it to
get the others *.h files (linux and asm). I do not have the SGI kernel
-- it is somewhere available? Alex said he will pack the sources as
RPM with configuration but I cannot find it on linus' ftp -- is it
somewhere there?

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
