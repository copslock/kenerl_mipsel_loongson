Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA66703 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 15:05:03 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA19520
	for linux-list;
	Wed, 17 Jun 1998 15:04:41 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA63485
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 15:04:39 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id PAA25824
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 15:04:37 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id AAA27136;
	Thu, 18 Jun 1998 00:04:34 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id AAA23137;
	Thu, 18 Jun 1998 00:04:33 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id AAA08176;
	Thu, 18 Jun 1998 00:04:33 +0200 (MET DST)
Message-Id: <199806172204.AAA08176@aisa.fi.muni.cz>
Subject: Re: What is the config of the kernel
In-Reply-To: <Pine.LNX.3.95.980617140831.8736B-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jun 17, 98 02:10:12 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 18 Jun 1998 00:04:32 +0200 (MET DST)
Cc: adelton@informatics.muni.cz, linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> I've got the one from Manhattan done, so that's okay.  And, uh, you are
> generating your packages as 'mipseb', not 'mips', eh?  'mips' in RPM is
> something we need to stamp out ASAP.

Hmmm, I just did rpm -i, rpm -bb, rpm -Uvh.

> It's clear I need to be a bit quicker in my uploading updates so that we
> don't end up replicating work. Sorry...

No, it's just that I wanted to try that it works. Let me know if there
is some compilation work I could let run on this Indy.

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
