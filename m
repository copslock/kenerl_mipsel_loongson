Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA67248 for <linux-archive@neteng.engr.sgi.com>; Fri, 19 Jun 1998 19:13:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA45363
	for linux-list;
	Fri, 19 Jun 1998 19:12:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA60395;
	Fri, 19 Jun 1998 19:12:56 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id TAA23306; Fri, 19 Jun 1998 19:12:54 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id WAA10739;
	Fri, 19 Jun 1998 22:12:52 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 19 Jun 1998 22:12:52 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Bob Mende Pie <mende@piecomputer.engr.sgi.com>
cc: linux@cthulhu.engr.sgi.com, dmk@cthulhu.engr.sgi.com
Subject: Re: more changes on linus.linux.sgi.com
In-Reply-To: <199806200158.SAA29080@piecomputer.engr.sgi.com>
Message-ID: <Pine.LNX.3.95.980619220903.9073A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, 19 Jun 1998, Bob Mende Pie wrote:
>   The system linus.linux.sgi.com now has a new disk configuration for /src.
> It is now a pair of high speed 4g drives mirrored (via xlv).   The old disk
> array is offline, but will not be recycled for at least a week.  Please let
> me know if you see any problems or data discrepencies.   

Good! Thanks!

>    The system is now a 150Mhz R4400 running on a Challenge/S.   Before we
> consider upgrading linus to run linux, we should have support for the
> Challenge/S.  I have a IO+ card free, but the backplate of the indy does
> not allow for it to fit into a box.  I am seeing if I can get a Challenge/S
> for loan for a few months so we can get it someone who can do the HW port
> for it.   It should be close to a no brainer since it is just a few more WD
> scsi chains and another ethernet (just like the internal one).

I'd definetly be interested in that port...  off the top of my head, it
doesn't sound difficult either.

I do really think that having some SGI/Linux machine within
*.linux.sgi.com would be good; if we're advocating that Linux on the SGI
is a reasonable proposition, it would prove a lot if we said that we were
hosting our own FTP and WWW sites on it.

However, there's definitely advantages to having Irix kicking around...
it's much easier having a reference Irix system for reference than
rebooting.


- Alex
