Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA18789 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 Aug 1998 13:43:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA59692
	for linux-list;
	Thu, 27 Aug 1998 13:43:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA21074
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Aug 1998 13:43:04 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA28692
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Aug 1998 13:43:03 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id WAA21105;
	Thu, 27 Aug 1998 22:42:17 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id WAA00451;
	Thu, 27 Aug 1998 22:42:16 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id WAA19985;
	Thu, 27 Aug 1998 22:42:15 +0200 (MET DST)
Message-ID: <19980827224215.C19688@aisa.fi.muni.cz>
Date: Thu, 27 Aug 1998 22:42:15 +0200
From: Honza Pazdziora <adelton@informatics.muni.cz>
To: Alex deVries <adevries@engsoc.carleton.ca>,
        Arnaud Le Neel <Arnaud.Le.Neel@cyceron.fr>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: boot problem for Indy
References: <35E59FBA.96A1900C@cyceron.fr> <Pine.LNX.3.96.980827131327.10299B-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.3.96.980827131327.10299B-100000@lager.engsoc.carleton.ca>; from Alex deVries on Thu, Aug 27, 1998 at 01:16:44PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> > Cannot reload bootp()server.cyceron.fr:vmlinux
> > Illegal f_magik number 0x7f45, expected MIPSELMAGIC or MIPSEBMAGIC
> > Unable to load bootp()server.cyceron.fr:vmlinux: execute format error
> > PS: Here is the description of the Indy i want to boot Linux:
> > 	IP22 100MHz R4000 with FPU
> 
> Hm.  Sounds to me like a processor thing.  Could that be, Ralf?  I'm not
> sure I've seen anyone try on an R4000 before, and if so, wha the
> implications of are for its cache.

I remember I tried to boot something like 2.1.7* on our older indy
with R4000 and the message was very much like this. Shall I retry?

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
