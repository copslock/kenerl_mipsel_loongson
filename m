Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA3200574 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Apr 1998 15:29:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA18049655
	for linux-list;
	Wed, 29 Apr 1998 15:28:25 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA18026630
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Apr 1998 15:28:23 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA11177
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Apr 1998 15:28:20 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id AAA10105;
	Thu, 30 Apr 1998 00:28:13 +0200 (MEST)
Received: by thoma (SMI-8.6/KO-2.0)
	id AAA03551; Thu, 30 Apr 1998 00:28:10 +0200
Message-ID: <19980430002810.03127@uni-koblenz.de>
Date: Thu, 30 Apr 1998 00:28:10 +0200
From: ralf@uni-koblenz.de
To: linux-kernel@vger.rutgers.edu
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Could mounting sdc instead of sdc1 have solved my panics?
References: <Pine.LNX.3.95.980429172646.16310M-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.95.980429172646.16310M-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Apr 29, 1998 at 05:29:55PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I don't see any reason why the kernel should crash when using sdc instead of
a partition.  So I forward this to linux-kernel in the hope anybody knows.

On Wed, Apr 29, 1998 at 05:29:55PM -0400, Alex deVries wrote:

> I redid my entire sdc because all my files were trashed on it anyway (with
> weird things like .h files having random data partway through...).  This
> time I partitioned using fx on Irix.
> 
> I didn't partition it the first time because I was lazy, and din't want to
> have to go through the weirdo fx tool thing.
> 
> Could this have been cause for my kernel panics? I've been doing a fair
> amount of work, and things seem really stable.  No panics so far.  Should
> /dev/sdc work just as a block device the way /dev/sdc1 would?

  Ralf
