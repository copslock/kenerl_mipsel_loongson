Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA83339 for <linux-archive@neteng.engr.sgi.com>; Mon, 5 Apr 1999 23:52:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA84900
	for linux-list;
	Mon, 5 Apr 1999 23:39:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA03429
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 5 Apr 1999 23:39:19 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup89-10-14.swipnet.se [130.244.89.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA01858
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Apr 1999 23:39:17 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id IAA08021;
	Tue, 6 Apr 1999 08:28:51 -0400
Date: Tue, 6 Apr 1999 08:28:51 -0400
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Charles Lepple <clepple@foo.tho.org>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: mpg123 hack
Message-ID: <19990406082851.A20241@bun.falkenberg.se>
Mail-Followup-To: Charles Lepple <clepple@foo.tho.org>,
	Linux SGI <linux@cthulhu.engr.sgi.com>
References: <19990405223315.A9898@bun.falkenberg.se> <37096F0C.64AE42F2@foo.tho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <37096F0C.64AE42F2@foo.tho.org>; from Charles Lepple on Tue, Apr 06, 1999 at 02:18:52AM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi Charles,

> Weird thought: what happens when you duplicate samples? (ie make the
> dumped samples the same as the ones which are played) It sounds like a
> common-mode rejection ratio problem

Whee!! That gives me PERFECT audio quality, well stereo and just 22050 Hz, but
no noise.  Can you explain to me what a common-mode rejection ratio problem is
and why it's solved in this odd way?

> You may find it helpful to patch the line-out jack from the Indy to the
> line-in on another system, and record it. If you can capture the noise
> with this arrangement, I'd be glad to take a look at it and see if
> there's any rhyme or reason to it.

Yeah, my noise is really exciting...

I'll try to find a decent cable so that I can record it.

> I'd love to help directly (I have 3 Indys in the lab to play with) but I
> still can't get a system to boot properly, as I don't maintain any
> Linux/x86 boxes on that subnet.

I'd be more than happy to receive some help!

- Ulf
