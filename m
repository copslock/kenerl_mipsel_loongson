Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA3640623 for <linux-archive@neteng.engr.sgi.com>; Sat, 2 May 1998 18:32:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA19412640
	for linux-list;
	Sat, 2 May 1998 18:26:36 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA17101401
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 2 May 1998 18:26:29 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id SAA08594
	for <linux@cthulhu.engr.sgi.com>; Sat, 2 May 1998 18:26:28 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id VAA31687;
	Sat, 2 May 1998 21:26:22 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sat, 2 May 1998 21:26:22 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Hanging.
In-Reply-To: <19980502125234.04479@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980502212341.4130G-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sat, 2 May 1998 ralf@uni-koblenz.de wrote:
> On Fri, May 01, 1998 at 02:20:22PM -0400, Alex deVries wrote:
> > This is a bit weird.   Once every 30 minutes or so, my Indy just sits
> > there and hangs.  Num lock will work, it'll ping, but there'll be no error
> > messages, and the system's useless.  After about 10 minutes of this, it'll
> > wake up as if nothing had happened.
> 
> Is it possibly about 64 seconds and not 10 minutes?  If so, we're loosing

Hm.  It's definitely more than 64 seconds.  It's happening right now, and
we're at 5 minutes by my watch.  It could be multiple 64 second hangs back
to back, though.  And I have a 134Mhz, I believe.

> If they keyboard is still working, try pressing <ALT>+<Scroll Lock>.  This
> should print a register dump.  That dump might end up in the syslog
> depending from your setup.  Does the keyboard still work (try toggling
> the caps lock led with caps lock)?  If you get such a register dump, could
> you please send it to me?

Yes, I will.  This will have to wait until I am at the console, though,
which can't be until tomorrow.  

- Alex
