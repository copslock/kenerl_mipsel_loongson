Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA12721 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 00:51:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA16464
	for linux-list;
	Fri, 17 Jul 1998 00:50:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA24239
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Jul 1998 00:50:35 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA04779
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Jul 1998 00:50:33 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id JAA00410;
	Fri, 17 Jul 1998 09:50:26 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id JAA04921;
	Fri, 17 Jul 1998 09:50:24 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id JAA25556;
	Fri, 17 Jul 1998 09:50:24 +0200 (MET DST)
Message-Id: <199807170750.JAA25556@aisa.fi.muni.cz>
Subject: Re: Message while mounting NFS
In-Reply-To: <Pine.LNX.3.95.980717012619.5792C-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jul 17, 98 01:28:19 am"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Fri, 17 Jul 1998 09:50:24 +0200 (MET DST)
Cc: dliu@npiww.com, adelton@informatics.muni.cz, linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> On Thu, 16 Jul 1998, Dong Liu wrote:
> > I think this is a bug of red hat system (BTW, where I can send them this bug
> > report?), portmapper is started after nfsfs, it should be started before
> > nfsfs.
> 
> Does starting portmapper before nfsfs actually work for you?  I still had

Thanks to all. Yes, installing portmap-4.0-11.mipseb.rpm and moving
S40portmap do S14portmap fixes the problem.

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
