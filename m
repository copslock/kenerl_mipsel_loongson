Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA68001 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 15:09:41 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA96724
	for linux-list;
	Wed, 17 Jun 1998 15:09:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA22086
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 15:09:09 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id PAA28675
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 15:09:00 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id AAA27540;
	Thu, 18 Jun 1998 00:08:57 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id AAA23306;
	Thu, 18 Jun 1998 00:08:56 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id AAA08385;
	Thu, 18 Jun 1998 00:08:55 +0200 (MET DST)
Message-Id: <199806172208.AAA08385@aisa.fi.muni.cz>
Subject: Re: Stuff that needs to be done.
In-Reply-To: <Pine.LNX.3.95.980617141204.8736C-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jun 17, 98 02:19:02 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 18 Jun 1998 00:08:55 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> - something appears to be wrong with mkswap

If this is the problem from me, if might be a problem with the disk
(I do not see into it however). The mkswap fails if I do not specify
the size.

> gcc
>      For inclusion in the packaging, it should really be regenerated from
>      the source RPM.  Needs lots of building time.

If you assume the make will go clean, I can start it right away.

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
