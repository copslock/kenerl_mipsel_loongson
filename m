Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA47440 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 11:11:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA91819
	for linux-list;
	Wed, 17 Jun 1998 11:10:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA85517
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 11:10:27 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id LAA17421
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 11:10:26 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA10541;
	Wed, 17 Jun 1998 14:10:12 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 17 Jun 1998 14:10:12 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: What is the config of the kernel
In-Reply-To: <199806171756.TAA26898@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.95.980617140831.8736B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 17 Jun 1998, Honza Pazdziora wrote:
> ;-) It's yours. BTW, I now checked that sysklog-1.3.26-1 from hurricane
> contrib can be compiled and run without problem. I have it in mips.rpm
> -- shall I upload it somewhere?

I've got the one from Manhattan done, so that's okay.  And, uh, you are
generating your packages as 'mipseb', not 'mips', eh?  'mips' in RPM is
something we need to stamp out ASAP.

It's clear I need to be a bit quicker in my uploading updates so that we
don't end up replicating work. Sorry...

- Alex
