Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA794580 for <linux-archive@neteng.engr.sgi.com>; Wed, 8 Apr 1998 17:15:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id RAA9537137
	for linux-list;
	Wed, 8 Apr 1998 17:14:46 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA9495285
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Apr 1998 17:14:45 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id RAA25374
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Apr 1998 17:14:43 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-07.uni-koblenz.de [141.26.249.7])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA26561
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Apr 1998 02:14:39 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id SAA13786;
	Tue, 7 Apr 1998 18:07:55 +0200
Message-ID: <19980407180755.64406@uni-koblenz.de>
Date: Tue, 7 Apr 1998 18:07:55 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Stuff I'm looking for.
References: <Pine.LNX.3.95.980406153705.19893Q-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980406153705.19893Q-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, Apr 06, 1998 at 03:37:49PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Apr 06, 1998 at 03:37:49PM -0400, Alex deVries wrote:

> I'm interested in finding the following things, before I invest time in
> recreating them:
> 
> 1. XFree stuff.
> Somewhere, somehow, I picked up a copy of /usr/X11R6/lib/libXaw.so.6.1,
> but I no longer remember who compiled it for SGI/Linux. Alan, maybe? In
> any case, when I try to run 'xterm' (which came in the same tarball,
> IIRC), I get a:
> libXaw.so.6: cannot open shared object file: No such file or directory
> although the file exists.

Check /etc/ld.so.conf.  It should contain a line ``/usr/X11R6/lib'' or
``/usr/X11R6/lib''.  If it's missing, add it and run /sbin/ldconfig.
Note that adding the path to LD_LIBRARY_PATH won't work for suid programs
like for example xterm.

> Does anyone have source patched I could turn into an RPM, or is this all
> pretty much just from the source?

Last X work I've done is a port of all XFree 3.3.1 (client only).  Miguel
was working on the kernel stuff for running Xsgi but got stalled due to
Gnome.  I'm currently travelling, so I don't have access to all my disks but
I *think* I've got the latest X sources with me; I'll attach a diff file.

> 2. binutils
> 
> I think my sdb has taken a bit of a crash, since I can compile properly
> only at certain times of the day.  Is there a binutils RPM out there
> anywhere, and if not, can people tell me a list of the required patches
> and latest version?

Native rpms are out there.

> Other notes:
> - When rpm 2.5 comes out later this week (possibly today), it'll have the
> problems with mipseb/mipsel sorted out.  Eventually all the RPMs on Linus
> in the mipsel are going to have to be replaced with repackaged ones.

The incompatibility isn't that bad; rpm can be forced to install rpms of
the other flavour safely.

>  When
> RedHat 5.1 comes out (my guess: early next month), I'll compile the mipseb
> packages.  In any case, I'll get mipsel RPMs out when 2.5 comes out for
> easy upgrading.

Ok.  When you upload srpms to linus, could you also keep a list online,
which of them have been modified?  That will keep upgrading / merging changes
back to Redhat easier.

> - I'm going to be in Raleigh-Durham for LinuxExpo May 28-30.  Is there any
> chance of us having an informal get together? 

I might be there.

  Ralf
