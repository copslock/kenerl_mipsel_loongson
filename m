Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA2663299 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Apr 1998 15:20:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA18281501
	for linux-list;
	Wed, 29 Apr 1998 15:19:00 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA16825635
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Apr 1998 15:18:57 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA07505
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Apr 1998 15:18:53 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id AAA09716;
	Thu, 30 Apr 1998 00:17:58 +0200 (MEST)
Received: by thoma (SMI-8.6/KO-2.0)
	id AAA03535; Thu, 30 Apr 1998 00:17:53 +0200
Message-ID: <19980430001752.34216@uni-koblenz.de>
Date: Thu, 30 Apr 1998 00:17:52 +0200
From: ralf@uni-koblenz.de
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: strace status?
References: <Pine.LNX.3.95.980429172006.16310L-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.95.980429172006.16310L-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Apr 29, 1998 at 05:21:35PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Apr 29, 1998 at 05:21:35PM -0400, Alex deVries wrote:

> How bad off is the strace that's in the CVS?  It seems to be working fine
> for me, although I'm not sure I understand if all the glibc patches were
> included.

We have some bug in the signal handling of our strace.  Aside of that it
seem to often work better than the Intel version.  Aside it our version was
also building for IRIX - at least before I started working on it.

The glibc in the CVS should have (almost) all my changes; I don't think that ever
anybody else commited changes.  If not, the RPM has them all.  Almost because
my recent patch for Dong Liu is missing and the pthread bug is still unfixed.

>            I'd like to merge the changes in that Miguel made into the
> redhat SRPMS, if they allow them (and I think they will).

As usual merging back sources is just a question of time and eloquentia ...

  Ralf
