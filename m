Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA60355 for <linux-archive@neteng.engr.sgi.com>; Sun, 21 Jun 1998 17:42:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA01513
	for linux-list;
	Sun, 21 Jun 1998 17:41:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAB82184
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 21 Jun 1998 17:41:32 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id RAA10940
	for <linux@cthulhu.engr.sgi.com>; Sun, 21 Jun 1998 17:41:31 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id UAA05025;
	Sun, 21 Jun 1998 20:41:30 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 21 Jun 1998 20:41:30 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
cc: Zach Brown <zab@zabbo.net>
Subject: Re: Ah, a problem with rpm!
In-Reply-To: <Pine.LNX.3.95.980621172757.20728H-100000@thebrain>
Message-ID: <Pine.LNX.3.95.980621203847.31228C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sun, 21 Jun 1998, Zach Brown wrote:
> > or similiar.  On my Indy, I _don't_ get the "Requires: " line at all. Do
> > other people?
> 
> have you checked the scripts that generate this stuff?  they have to be
> geneated per port of rpm, if I remember right.  sorry i'm being so vague.

Yes, the issue is that the rpm RPM that I released (2.5.1-0) has a broken
find-requires (which happened because the binutils RPM I used didn't have
a /usr/lib/ldscripts).  So, all packages generated wouldn't have any
requires setup.

Ack.

So, time to rebuild the whole damned distribution again, although this
time I know how to do it.

Let me know if you've got CPU power to spare, folks... I'll set up a
co-ordinated build, and release a proper version of rpm.


- Alex
