Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA78533 for <linux-archive@neteng.engr.sgi.com>; Tue, 6 Apr 1999 00:03:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA27500
	for linux-list;
	Mon, 5 Apr 1999 23:57:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA78853
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 5 Apr 1999 23:57:45 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup71-5-6.swipnet.se [130.244.71.70]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA01096
	for <linux@cthulhu.engr.sgi.com>; Mon, 5 Apr 1999 23:57:43 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id IAA16816;
	Tue, 6 Apr 1999 08:47:28 -0400
Date: Tue, 6 Apr 1999 08:47:28 -0400
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Charles Lepple <clepple@foo.tho.org>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: mpg123 hack
Message-ID: <19990406084728.A8313@bun.falkenberg.se>
Mail-Followup-To: Charles Lepple <clepple@foo.tho.org>,
	Linux SGI <linux@cthulhu.engr.sgi.com>
References: <19990405223315.A9898@bun.falkenberg.se> <37096F0C.64AE42F2@foo.tho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <37096F0C.64AE42F2@foo.tho.org>; from Charles Lepple on Tue, Apr 06, 1999 at 02:18:52AM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi again,

The problem seems to be that the HAL2 because of some strange reason I don't
know requires the samples to be duplicated. There's no doubt about that the HAL2
is in stereo mode though, I print the registers every time the card is
triggered. One might otherwise think that I accidently had set it up into Quad
mode.

I can now play MP3 in 44100Hz, stereo with perfect audio quality, when the
samples are duplicated..

- Ulf
