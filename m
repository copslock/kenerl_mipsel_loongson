Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA3728267 for <linux-archive@neteng.engr.sgi.com>; Mon, 4 May 1998 12:46:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA20023579
	for linux-list;
	Mon, 4 May 1998 12:45:54 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA19376096
	for <linux@engr.sgi.com>;
	Mon, 4 May 1998 12:45:52 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA16040
	for <linux@engr.sgi.com>; Mon, 4 May 1998 12:45:50 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id PAA21132;
	Mon, 4 May 1998 15:45:41 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 4 May 1998 15:45:41 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
Reply-To: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: tim@cobaltmicro.com, linux@cthulhu.engr.sgi.com
Subject: Re: Hanging.
In-Reply-To: <19980504213205.32754@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980504153806.11760N-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Mon, 4 May 1998 ralf@uni-koblenz.de wrote:
> I cc this to Tim.  DaveM is also reading this list, so they'll know.
> The problem isn't too bad.  Once new rpm binaries have been installed
> those
> will know about mipsel/mipseb.  And we _had_ to break compatibility,
> remember the purpose was to make the two flavours and the old ``mips''
> flavour different and distinguishable from each other.

Yes.  We had to break compatibility.  It's just disappointing that the
SGI-Linux, Cobalt Micro and RPM flks disn't come to a consensus on it.
And really, I'm not laying blame, I'm trying to find a solution to it.

Right now, Qube users will have the following problems:
- they will build RPMs that are tagged as arch 4, which isn't in line
  with the standard that RPM and SGI-Linux agreed to
- they will have to use --ignorearch when installing contribbed RPMs
- RPM will not complain when installing incompatible mipseb packages

Even if the Cobalt ships and update with RPM 2.4.109 or similiar:
- the binaries that Cobalt already ships with (and I assume they do) will
have to be regenerated

We really need some input from Cobalt on this issue.  Tim?

- Alex
