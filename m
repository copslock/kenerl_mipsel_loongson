Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA51583 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 12:17:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA97253
	for linux-list;
	Wed, 17 Jun 1998 12:17:05 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA28158
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 12:17:03 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id MAA23077
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 12:17:00 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-14.uni-koblenz.de [141.26.249.14])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id VAA09304
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 21:16:53 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id VAA00661;
	Wed, 17 Jun 1998 21:16:24 +0200
Message-ID: <19980617211616.A410@uni-koblenz.de>
Date: Wed, 17 Jun 1998 21:16:16 +0200
To: Honza Pazdziora <adelton@informatics.muni.cz>, linux@cthulhu.engr.sgi.com
Subject: Re: ssh 1.2.25 mipseb rpm
References: <Pine.LNX.3.95.980616120817.26590C-100000@lager.engsoc.carleton.ca> <199806171240.OAA04748@aisa.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199806171240.OAA04748@aisa.fi.muni.cz>; from Honza Pazdziora on Wed, Jun 17, 1998 at 02:40:48PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jun 17, 1998 at 02:40:48PM +0200, Honza Pazdziora wrote:

> I've displayed mipseb rpms of ssh on
> 
> ftp://ftp.fi.muni.cz/pub/ssh/local-fi.muni.cz/linux/
> 
> You need all four rpms for complete system. The rpms were compiled
> without the X11 support.

Last Sunday or so I've uploaded a full set of RPMs including X11 support
to ftp.replay.com.  That included all the combinations of big and little
endian, international and US versions.  To avoid legal problems the
rpms are only available on ftp.replay.com which is in the Netherlands.
Another legal kludge is the special US version.  It uses the RSAREF
reference implementation which is requered to to the legal braindamage
in the US also known as software patents.

  Ralf
