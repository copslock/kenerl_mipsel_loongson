Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id JAA01843 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 09:07:14 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA16676 for linux-list; Mon, 12 Jan 1998 09:02:11 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA16664 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 09:02:10 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA25829
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 09:02:06 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-16.uni-koblenz.de [141.26.249.16])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id SAA17959
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 18:02:03 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id RAA01726;
	Mon, 12 Jan 1998 17:56:43 +0100
Message-ID: <19980112175643.05482@uni-koblenz.de>
Date: Mon, 12 Jan 1998 17:56:43 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: BlueBelt Linux for SGI
References: <Pine.LNX.3.95.980111212314.26800H-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980111212314.26800H-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sun, Jan 11, 1998 at 09:47:11PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jan 11, 1998 at 09:47:11PM -0500, Alex deVries wrote:

> I'm just about finished all I can bear for one weekend. I've made one pass
> over every single source RPM from RedHat 5.0 with the intention of
> finishing off a decent distribution called BlueBelt 5.0 (IceStorm).

Duh, thought 5.0 is Hurricane?

> There's 452 binary RPMs that qualify as being suitable for SGI; eg. 
> SVGALib doesn't make a lot of sense on an Indy.  Of those, I tried
> compiling about 410. I have 285 binaries, 50 noarchs and about 75
> failures.

Be carefull, a couple of RPM don't make sense for MIPS boxes but they
build nevertheless.  Got burned by this ...

>            A lot of those failures are simply because of the order I built
> everything in;  eg. I built gpm-devel late in the game, so things like mc
> didn't compile. 
> 
> Within an hour, you'll be able to see the whole thing at
> http://www.linux.sgi.com/bluebelt/. Uploading the packages is going to
> take overnight, although there are a lot of them there already. They'll be
> in ftp://ftp.linux.sgi.com/pub/RedHat/RPMS/ .

Yesterday I've rearranged the Redhat tree a little bit, it's now
/pub/redhat/redhat-{4.9.1,5.0}.  To put a bit of cream on top of
it I also finally uploaded that glibc 2.0.6 RPMS that were getting
old on my disk.

> Please, if you would like to help me sort out the remaining packages,
> please consult the list first.  It'll give some indication if that package
> has been successfully converted already. Let me know, and I'll sign the
> package as I have the others, and I'll update the WWW page accordingly.  I
> put a lot of time into organizing all the packages on the WWW, please use
> it as a guide to what needs to be done.

Www?  ipfwadm brings prompt releave ;-)

> - Alex "praying RH 5.1 won't come out anytime really soon" deVries

  :-)

  Ralf
