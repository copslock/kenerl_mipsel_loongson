Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA52080 for <linux-archive@neteng.engr.sgi.com>; Fri, 25 Dec 1998 04:58:24 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA34874
	for linux-list;
	Fri, 25 Dec 1998 04:57:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA52586
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 25 Dec 1998 04:57:30 -0800 (PST)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00898
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Dec 1998 04:57:27 -0800 (PST)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id NAA25508;
	Fri, 25 Dec 1998 13:57:19 +0100 (MET)
Received: from aisa.fi.muni.cz (aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id NAA05328;
	Fri, 25 Dec 1998 13:57:17 +0100 (MET)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id NAA13966;
	Fri, 25 Dec 1998 13:57:17 +0100 (MET)
Message-ID: <19981225135717.A13760@aisa.fi.muni.cz>
Date: Fri, 25 Dec 1998 13:57:17 +0100
From: Honza Pazdziora <adelton@informatics.muni.cz>
To: Dave Babcock <daveb@sgi.com>,
        Honza Pazdziora <adelton@informatics.muni.cz>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Are we going to port RH 5.2?
References: <19981223201347.A10620@aisa.fi.muni.cz> <36814203.6C516B88@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <36814203.6C516B88@sgi.com>; from Dave Babcock on Wed, Dec 23, 1998 at 11:18:27AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> What was your secret to getting SGI/Linux on your Indy?

It was quite straightforward.

> I've been trying to do it for several days but with no luck.  The online
> instructions give directions for using another IA32 linux box which I've
> tried adapting to use my second Indy running 6.5.  I'm sure that's where
> the problem is but don't know the "secret incantation" to make it work.
> 
> Any help or pointers would be appreciated.

OK, start with telling us what steps from the installation
instructions (I assume you are going by
http://www.linux.sgi.com/manhattan/) you did, how you did them and
where did the results start to differ from what you expected.

For debugging during the initiation phase, I recommend to have tcpdump
at hand so that you can check if the packets are running the way they
should.

[CC'ed back to linux@cthulhu.engr.sgi.com, so that the others could
comment as well.]

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
		Boycott the Czech Telecom -- www.bojkot.cz
------------------------------------------------------------------------
