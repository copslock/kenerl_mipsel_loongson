Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA09392 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 09:36:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA19225
	for linux-list;
	Thu, 16 Jul 1998 09:35:00 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA10421
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 09:34:57 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA25011
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 09:34:55 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id SAA07858;
	Thu, 16 Jul 1998 18:24:42 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id SAA15537;
	Thu, 16 Jul 1998 18:24:37 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id SAA14564;
	Thu, 16 Jul 1998 18:24:40 +0200 (MET DST)
Message-Id: <199807161624.SAA14564@aisa.fi.muni.cz>
Subject: Re: Installing noarch packages
In-Reply-To: <199807161617.SAA14485@aisa.fi.muni.cz> from Honza Pazdziora at "Jul 16, 98 06:17:57 pm"
To: adelton@informatics.muni.cz (Honza Pazdziora)
Date: Thu, 16 Jul 1998 18:24:40 +0200 (MET DST)
Cc: adelton@informatics.muni.cz, adevries@engsoc.carleton.ca,
        linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> This is with rpm version 2.5.1 from HH 5.1 PR distribution. I even
> tried to build the automake rpm from src, got rpm fine but then
> ended with the same message. So I assume there is something wrong
> not with the noarch packages but with the rpm.

I forgot to say that you can of course install it with --ignorearch.
Still, this might be the problem why the devices installfailed,
couldn't it?

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
