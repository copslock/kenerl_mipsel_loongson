Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA46952 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 10:45:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA24584
	for linux-list;
	Wed, 17 Jun 1998 10:44:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA66532
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 10:44:14 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id KAA02973
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 10:44:12 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA09448;
	Wed, 17 Jun 1998 13:44:04 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 17 Jun 1998 13:44:04 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: What is the config of the kernel
In-Reply-To: <199806171701.TAA23039@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.95.980617134253.8736A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 17 Jun 1998, Honza Pazdziora wrote:
> Hello,
> 
> what is the correct kernel configuration for that 2.1.99 in the RH 5.1
> Alpha 1? We tried to take regular kernel, make config and make dep run
> fine but then it failed with a lot of messages (I can send them if
> needed). So the question is: when I would like to try to compile my
> own kernel (just for the fun of it ;-), what are the recommended steps?

That is a good question, and one I'm solving now.

You need the kernel out of the CVS; the regular one will not work.

I'm in the midst of packaging up the kernel source as an RPM, complete
with a default config.  Give me 24 hours.

- alex
