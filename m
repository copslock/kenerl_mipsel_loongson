Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA34821 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 10:58:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA48955
	for linux-list;
	Wed, 17 Jun 1998 10:56:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA03489
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 10:56:37 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id KAA09818
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 10:56:35 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id TAA19598;
	Wed, 17 Jun 1998 19:56:28 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id TAA16943;
	Wed, 17 Jun 1998 19:56:27 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id TAA26898;
	Wed, 17 Jun 1998 19:56:26 +0200 (MET DST)
Message-Id: <199806171756.TAA26898@aisa.fi.muni.cz>
Subject: Re: What is the config of the kernel
In-Reply-To: <Pine.LNX.3.95.980617134253.8736A-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jun 17, 98 01:44:04 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Wed, 17 Jun 1998 19:56:26 +0200 (MET DST)
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
> That is a good question, and one I'm solving now.
> 
> You need the kernel out of the CVS; the regular one will not work.
> 
> I'm in the midst of packaging up the kernel source as an RPM, complete
> with a default config.  Give me 24 hours.

;-) It's yours. BTW, I now checked that sysklog-1.3.26-1 from hurricane
contrib can be compiled and run without problem. I have it in mips.rpm
-- shall I upload it somewhere?

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
