Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA78113 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Apr 1999 14:23:11 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA15132
	for linux-list;
	Tue, 13 Apr 1999 14:19:25 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA21758
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 13 Apr 1999 14:19:20 -0700 (PDT)
	mail_from (adisaacs@mtu.edu)
Received: from news.mtu.edu (news.mtu.edu [141.219.70.11]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA02149
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Apr 1999 14:19:18 -0700 (PDT)
	mail_from (adisaacs@mtu.edu)
Received: from mtu.edu (root@mtu.edu [141.219.70.1])
	by news.mtu.edu (8.8.8/8.8.8) with ESMTP id RAA12932;
	Tue, 13 Apr 1999 17:19:07 -0400 (EDT)
Received: from wiley.sas.it.mtu.edu (wiley.sas.it.mtu.edu [141.219.36.70])
	by mtu.edu (8.8.8/8.8.8) with ESMTP id RAA19180;
	Tue, 13 Apr 1999 17:19:07 -0400 (EDT)
Received: (from adisaacs@localhost)
	by wiley.sas.it.mtu.edu (8.8.7/8.8.7/mturelay-1.2) id RAA02840;
	Tue, 13 Apr 1999 17:18:50 -0400 (EDT)
Date: Tue, 13 Apr 1999 17:18:50 -0400
From: Andrew Isaacson <adisaacs@mtu.edu>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: alan@lxorguk.ukuu.org.uk, linux@cthulhu.engr.sgi.com
Subject: Re: Resources in X11 port
Message-ID: <19990413171850.A2473@mtu.edu>
References: <m10X8aD-0007TvC@the-village.bc.nu> <199904131345.IAA15796@metropolis.nuclecu.unam.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <199904131345.IAA15796@metropolis.nuclecu.unam.mx>; from Miguel de Icaza on Tue, Apr 13, 1999 at 08:45:58AM -0500
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://www.csl.mtu.edu/~adisaacs/pgp.txt
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Apr 13, 1999 at 08:45:58AM -0500, Miguel de Icaza wrote:
> 
> > I would urge btw that anyone working on an XFree SGI driver
> > releases it under a license like the NPL so that the XFree people
> > can't hide it in a locked away beta release in future.
> 
> Will they incorporate those changes though?

No.  XFree86 will not incorporate any code which is not licensed to
them under an X-compatible license.

That doesn't prevent someone from providing a driver under a different
license (very possibly including the XFree86 code under that license),
but a driver not under an X license will not become part of XFree86.

-andy (not speaking for XFree86)
-- 
Andy Isaacson adisaacs@mtu.edu adi@acm.org    Fight Spam, join CAUCE:
http://www.csl.mtu.edu/~adisaacs/              http://www.cauce.org/
