Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA700285 for <linux-archive@neteng.engr.sgi.com>; Sun, 30 Nov 1997 09:34:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA00680 for linux-list; Sun, 30 Nov 1997 09:29:46 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA00660 for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 09:29:39 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA27512
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 09:29:37 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-10.uni-koblenz.de [141.26.249.10])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id SAA12314
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 18:29:24 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id RAA01489;
	Sun, 30 Nov 1997 17:29:19 +0100
Message-ID: <19971130172918.59762@uni-koblenz.de>
Date: Sun, 30 Nov 1997 17:29:18 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alex deVries <adevries@engsoc.carleton.ca>, linux@cthulhu.engr.sgi.com
Subject: Re: A report from the battle field...
References: <Pine.LNX.3.95.971129193017.26978E-100000@lager.engsoc.carleton.ca> <m0xcAil-0005FsC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <m0xcAil-0005FsC@lightning.swansea.linux.org.uk>; from Alan Cox on Sun, Nov 30, 1997 at 02:51:43PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Nov 30, 1997 at 02:51:43PM +0000, Alan Cox wrote:

> > 1. When I try to FTP a lot of files to it, it complains about "eth0: ".  I
> > guess it's just going too quick.  The file then becomes corrupt.  The
> 
> Yep. Part of that however might be the ftp binary - ncftp I get
> the eth0: errors but dont seem to get file corruption.
> 
> > 2. Execution errors on various programs:
> > - bash: 
> > do_page_fault() #2: sending SIGSEGV to bash for illegal readaccess
> > from 000000d0 (epc ==0fb676c0, ra == 0fb676a0)
> > - pico (part of pine):
> > do_page_fault() #2: sending SIGSEGV to pico for illegal readaccess from
> > from 000000d0 (epc ==0fb676c0, ra == 0fb676a0)

These addresses are in the dynamic linker.  It's fixed in the CVS tree.
I however still see alot of unexplainable segmentation faults on my
machine.  Built from the same sources I don't see that problem on my
other machines, so I'd point at the Indy specific parts.

The crashes related to the ethernet are the most annoying things right now.

  Ralf
