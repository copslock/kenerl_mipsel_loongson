Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA00169 for <linux-archive@neteng.engr.sgi.com>; Mon, 5 Apr 1999 07:14:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA83664
	for linux-list;
	Mon, 5 Apr 1999 07:08:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA78955
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 5 Apr 1999 07:08:47 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA01302
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Apr 1999 07:08:43 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id KAA10558;
	Mon, 5 Apr 1999 10:08:35 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 5 Apr 1999 10:08:35 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: milos@kprc.com
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: New Indy kernel uploaded
In-Reply-To: <3708BC61.AF904C06@insync.net>
Message-ID: <Pine.LNX.3.96.990405100819.7562A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hardhat itself should format the partition for you; the ext2 on irix is
slightly broekn.

-- 
Alex deVries, puffin on LinuxNet.
Linux on HP PA RISC. The final frontier.

On Mon, 5 Apr 1999, Miles Lott wrote:

> This is working for me, too - to a point.  I get stuck
> just past the package selection and the message that a log
> will be created.  It looks as if it is hanging trying to
> mount the linux partition.  So, stupid question.  The 
> install instructions say to begin by running fx and setting
> up a root partition on the second disk from within IRIX.
> So, am I supposed to format ext2 from within the Hardhat setup
> program?  Or, rather, at what point is the partition formatted
> suitably for the Hardhat install to begin unpacking files on it?
> TIA
> 
> Thomas Bogendoerfer wrote:
> > 
> > On Tue, Mar 30, 1999 at 09:43:16AM +0200, Tom Woelfel wrote:
> > > Yep, done. Works without problems - Linux is up and running. How do
> > > you solve the problems with the ECOFF/ELF thing ? Is there some kind
> > > of backwards-compatibility ?
> > 
> > yes, every newer PROM is also able to boot ECOFF kernels. So I just
> > uploaded an ECOFF kernel, which should work with every PROM.
> > 
> > Thomas.
> > 
> > --
> >    This device has completely bogus header. Compaq scores again :-|
> > It's a host bridge, but it should be called ghost bridge instead ;^)
> >                                         [Martin `MJ' Mares on linux-kernel]
> 
