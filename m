Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA3162532 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Apr 1998 15:35:38 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA18264158
	for linux-list;
	Wed, 29 Apr 1998 15:34:51 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA18271886
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Apr 1998 15:34:48 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA13904
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Apr 1998 15:34:44 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id SAA00422;
	Wed, 29 Apr 1998 18:34:27 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 29 Apr 1998 18:34:27 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: strace status?
In-Reply-To: <19980430001752.34216@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980429183102.16310N-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 30 Apr 1998 ralf@uni-koblenz.de wrote:
> We have some bug in the signal handling of our strace.  Aside of that it
> seem to often work better than the Intel version.  Aside it our version was
> also building for IRIX - at least before I started working on it.

Cool.

> The glibc in the CVS should have (almost) all my changes; I don't think that ever
> anybody else commited changes.  If not, the RPM has them all.  Almost because
> my recent patch for Dong Liu is missing and the pthread bug is still unfixed.

Cool, too.  Now, is 2.0.7 worth generating for any reason?

> >            I'd like to merge the changes in that Miguel made into the
> > redhat SRPMS, if they allow them (and I think they will).

Both Erik Troan and Alan have mentioned the possibility of RH taking our
patches, although we should really work on getting the patches to strace
put into the main stream.

I'll talk to the strace folks...

- Alex
