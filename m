Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA3607134 for <linux-archive@neteng.engr.sgi.com>; Sat, 2 May 1998 03:54:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA19325169
	for linux-list;
	Sat, 2 May 1998 03:52:57 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA14794009
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 2 May 1998 03:52:55 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id DAA05641
	for <linux@cthulhu.engr.sgi.com>; Sat, 2 May 1998 03:52:53 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-11.uni-koblenz.de [141.26.249.11])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id MAA22816
	for <linux@cthulhu.engr.sgi.com>; Sat, 2 May 1998 12:52:50 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id MAA04076;
	Sat, 2 May 1998 12:52:35 +0200
Message-ID: <19980502125234.04479@uni-koblenz.de>
Date: Sat, 2 May 1998 12:52:34 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Hanging.
References: <Pine.LNX.3.95.980501141729.22853C-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980501141729.22853C-100000@lager.engsoc.carleton.ca>; from Alex deVries on Fri, May 01, 1998 at 02:20:22PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, May 01, 1998 at 02:20:22PM -0400, Alex deVries wrote:

> This is a bit weird.   Once every 30 minutes or so, my Indy just sits
> there and hangs.  Num lock will work, it'll ping, but there'll be no error
> messages, and the system's useless.  After about 10 minutes of this, it'll
> wake up as if nothing had happened.

Is it possibly about 64 seconds and not 10 minutes?  If so, we're loosing
timer interrupts.  This doesn't happen for me and in current kernels we
should actually be safe from this with the exception of 100MHz R4000.

If they keyboard is still working, try pressing <ALT>+<Scroll Lock>.  This
should print a register dump.  That dump might end up in the syslog
depending from your setup.  Does the keyboard still work (try toggling
the caps lock led with caps lock)?  If you get such a register dump, could
you please send it to me?

> This is with 2.1.91.
> 
> Ideas? My initial suspicion is my SCSI bus, although I'm getting no kernel
> errors at all. 

The Indy driver should be pretty stable as it's based on another stone age
driver for various Amiga hostadapters.

There are actually a couple of funny ones in the generic .91 code which
fried that kernel several times for me; on configurations that are
supported the bugs in the portable Linux code are beginning to be the
limit ...

  Ralf
