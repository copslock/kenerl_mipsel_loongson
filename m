Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id BAA18868 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Jun 1998 01:59:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA70537
	for linux-list;
	Mon, 22 Jun 1998 01:59:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA60915
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Jun 1998 01:58:59 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id BAA21025
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Jun 1998 01:58:56 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id KAA09882
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Jun 1998 10:58:54 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id KAA01275;
	Mon, 22 Jun 1998 10:58:24 +0200
Message-ID: <19980622105824.D418@uni-koblenz.de>
Date: Mon, 22 Jun 1998 10:58:24 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Ah, a problem with rpm!
References: <Pine.LNX.3.95.980621183716.31228B-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.95.980621183716.31228B-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sun, Jun 21, 1998 at 06:44:43PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jun 21, 1998 at 06:44:43PM -0400, Alex deVries wrote:

> The solution to this is either to fix the build environment or rpm, and
> then rebuild pretty much all the packages.  *sigh*
> 
> The stuff to look for is:
> 
> ...
> Processing files: hello
> Finding provides...
> Finding requires...
> Prereqs: /bin/sh
> Requires: ld-linux.so.2 libc.so.6
> Wrote: /usr/src/redhat/SRPMS/hello-0.10-2.src.rpm
> Wrote: /usr/src/redhat/RPMS/i386/hello-0.10-2.i386.rpm
> ...
> 
> or similiar.  On my Indy, I _don't_ get the "Requires: " line at all. Do
> other people?

I do get them.  If you don't get them, then probably ldd isn't working
on your machine.  There was a kernel bug causing this and the bugfix is
in the CVS since quite some time.

  Ralf
