Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA165155 for <linux-archive@neteng.engr.sgi.com>; Wed, 6 May 1998 07:54:41 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA18192879
	for linux-list;
	Wed, 6 May 1998 07:53:22 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA21147843
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 6 May 1998 07:53:18 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id HAA29335
	for <linux@cthulhu.engr.sgi.com>; Wed, 6 May 1998 07:53:17 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id KAA17390;
	Wed, 6 May 1998 10:53:06 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 6 May 1998 10:53:06 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Leon Verrall <leon@reading.sgi.com>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Missing something obvious?
In-Reply-To: <Pine.SGI.3.96.980506115727.3785C-100000@wintermute.reading.sgi.com>
Message-ID: <Pine.LNX.3.95.980506102339.16251A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 6 May 1998, Leon Verrall wrote:
> Apologies for launching in with nowt but a question but I'm obviously
> missing something on the SGI Linux installation...
> I've downloaded a built kernel, root-be-0.03.cpio and the installer prog,
> built a filesystem, got the files on etc. and can boot to single user. The
> question is; "Where do I go from here?". On the one hand I have the kernel
> source, a gcc RPM, glibc tarball etc. and on the other a machine with a
> _bare_ bones system (i.e. won't get to init 2 as no scripts on /etc/rc2.d/,
> mount fails to mount /etc/fstab entries prompting rc.sysinit hacking etc...)

Leon,

	I doubt there's anyone on this list that can defend the clarity of
the documentation on the WWW site.

	The next goal is this: download all the RPMs, and install them via
FTP.  You can get the RPMs themselves from
ftp.linux.sgi.com/pub/redhat/hurricane/ or similiar.  Those packages make
up something like 80% of Red Hat 5.0.

	When looking for the RPMs, remember that SGIs use 'mipseb'
binaries, NOT mipsel.

	And, let us know how it goes.

- Alex
