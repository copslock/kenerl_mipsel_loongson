Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA19508 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Mar 1999 14:50:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA56957
	for linux-list;
	Thu, 11 Mar 1999 14:47:06 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA03038
	for <linux@engr.sgi.com>;
	Thu, 11 Mar 1999 14:47:03 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA15666
	for <linux@engr.sgi.com>; Thu, 11 Mar 1999 14:46:47 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-18.uni-koblenz.de [141.26.131.18])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA26271
	for <linux@engr.sgi.com>; Thu, 11 Mar 1999 23:30:20 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id XAA01456;
	Thu, 11 Mar 1999 23:25:44 +0100
Message-ID: <19990311232542.A1385@uni-koblenz.de>
Date: Thu, 11 Mar 1999 23:25:42 +0100
From: ralf@uni-koblenz.de
To: Jake Griesbach <griesbac@gamera.colorado.edu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Linux/Mips installation
References: <19990311010022.A1006@alpha.franken.de> <Pine.LNX.3.96.990311103856.28421A-100000@gamera.colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.990311103856.28421A-100000@gamera.colorado.edu>; from Jake Griesbach on Thu, Mar 11, 1999 at 10:44:15AM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Mar 11, 1999 at 10:44:15AM -0700, Jake Griesbach wrote:

> Thanks, that helped.  I didn't have the kernel installed correctly.  Now
> the system boots by itself and runs linux!
> 
> I've noticed that the web pages haven't been updated for a while.  Is X
> available?  I get the following errors when I try to run X (with startx):
> 
> _X11TransSocketUNIXConnect: Can't connect: errno = 146
> 
> This repeats until I kill startx.  Also, I'm not familiar with the Red-Hat
> linux flavor.  How do I start the package manager to get the latest set of
> packages?

Well, that's ok because it's what is supposed to happen where you're trying
to run X without a server.  But we've got a full set of clients.

  Ralf
