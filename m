Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA16946 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 16:07:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA11742 for linux-list; Wed, 14 Jan 1998 16:06:56 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA11732 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 16:06:55 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA27344
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 16:06:53 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-17.uni-koblenz.de [141.26.249.17])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA03560
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 01:06:50 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA05793;
	Thu, 15 Jan 1998 01:03:37 +0100
Message-ID: <19980115010335.21821@uni-koblenz.de>
Date: Thu, 15 Jan 1998 01:03:35 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: The world's worst RPM
References: <m0xsb7r-0005FsC@lightning.swansea.linux.org.uk> <Pine.LNX.3.95.980114171159.2369M-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980114171159.2369M-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Jan 14, 1998 at 05:25:31PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 14, 1998 at 05:25:31PM -0500, Alex deVries wrote:

> On Wed, 14 Jan 1998, Alan Cox wrote:
> > > hmm, to do this with only one src.rpm, we need a little support from
> > > rpm. At the moment mips is defined for mipsel and mipseb. I would suggest,
> > > that for .spec execution mips is defined for bot mipsel and mipseb, because 
> > > there are changes, which work for both and we only need to seperate changes 
> > > like that needed by ncompress.  Comments ? Does anybody how to do this ?
> > Just ask Erik Troan nicely 
> 
> He has already agreed to it, I just need to submit my patches to RPM that
> do the detection of the byte order for setting the soft-coded default
> architecture. It'll be done by the end of the week.

Ah, you were the volunteer :-)  Recently I fixed RPM already, so we should
somewhen deciede who's patch is the nicer.

  Ralf
