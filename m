Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA478017; Fri, 22 Aug 1997 18:25:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA23688 for linux-list; Fri, 22 Aug 1997 18:25:34 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA23679 for <linux@cthulhu.engr.sgi.com>; Fri, 22 Aug 1997 18:25:32 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA04904
	for <linux@cthulhu.engr.sgi.com>; Fri, 22 Aug 1997 18:25:18 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id DAA27638; Sat, 23 Aug 1997 03:25:16 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708230125.DAA27638@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id DAA07716; Sat, 23 Aug 1997 03:25:12 +0200
Subject: Re: Kernel compile errors...
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Sat, 23 Aug 1997 03:25:11 +0200 (MET DST)
Cc: miguel@nuclecu.unam.mx, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.970822171154.1607C-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Aug 22, 97 05:15:11 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > > I just checked out the latest kernel, and I get the following errors when
> > > I try to compile. Uh, what am I doing wrong?  I'm afraid MIPS assembler is
> > > above me.
> > 
> > Strange, I have been using the gcc and binutils packages put together
> > by Ralf for a long time, it is not the stock gcc/binutils, probably
> > this is your problem?
> 
> I don't think so.  The ones I'm using are those from Ralf as well.  I will
> double check to make sure.

This is a bug which I fixed in my version of binutils, so ...

  Ralf
