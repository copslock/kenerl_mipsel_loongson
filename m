Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA184025 for <linux-archive@neteng.engr.sgi.com>; Wed, 6 May 1998 17:17:07 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA20800636
	for linux-list;
	Wed, 6 May 1998 17:14:57 -0700 (PDT)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA21515786;
	Wed, 6 May 1998 17:14:52 -0700 (PDT)
Received: (from ariel@localhost) by oz.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id RAA10832; Wed, 6 May 1998 17:14:52 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199805070014.RAA10832@oz.engr.sgi.com>
Subject: Re: Missing something obvious?
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Wed, 6 May 1998 17:14:52 -0700 (PDT)
Cc: leon@reading.sgi.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.980506102339.16251A-100000@lager.engsoc.carleton.ca> from "Alex deVries" at May 6, 98 10:53:06 am
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:
:On Wed, 6 May 1998, Leon Verrall wrote:
:> Apologies for launching in with nowt but a question but I'm obviously
:> missing something on the SGI Linux installation...
:> I've downloaded a built kernel, root-be-0.03.cpio and the installer prog,
:> built a filesystem, got the files on etc. and can boot to single user. The
:> question is; "Where do I go from here?". On the one hand I have the kernel
:> source, a gcc RPM, glibc tarball etc. and on the other a machine with a
:> _bare_ bones system (i.e. won't get to init 2 as no scripts on /etc/rc2.d/,
:> mount fails to mount /etc/fstab entries prompting rc.sysinit hacking etc...)
:
:Leon,
:
:	I doubt there's anyone on this list that can defend the clarity of
:the documentation on the WWW site.
:
:	The next goal is this: download all the RPMs, and install them via
:FTP.  You can get the RPMs themselves from
:ftp.linux.sgi.com/pub/redhat/hurricane/ or similiar.  Those packages make
:up something like 80% of Red Hat 5.0.
:
:	When looking for the RPMs, remember that SGIs use 'mipseb'
:binaries, NOT mipsel.
:
:	And, let us know how it goes.
:
:- Alex
:

Do we have a volunteer who has gone through the process
and can update the HOWTO ?

If the volunteer doesn't have ssh access to linus,
just email me the public key and desired username
and (s)he'll be granted access.

Thanks!
-- 
Peace, Ariel
