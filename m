Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA44054 for <linux-archive@neteng.engr.sgi.com>; Thu, 25 Jun 1998 15:12:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA13214
	for linux-list;
	Thu, 25 Jun 1998 15:11:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA10499
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 Jun 1998 15:11:51 -0700 (PDT)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-46.netscape.com [205.217.237.46]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id PAA14226
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 Jun 1998 15:11:51 -0700 (PDT)
	mail_from (shaver@netscape.com)
Received: from dredd.mcom.com (dredd.mcom.com [205.217.237.54])
	by netscape.com (8.8.5/8.8.5) with ESMTP id PAA24463
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 Jun 1998 15:11:43 -0700 (PDT)
Received: from netscape.com ([205.217.243.67]) by dredd.mcom.com
          (Netscape Messaging Server 3.52)  with ESMTP id AAA199F;
          Thu, 25 Jun 1998 15:11:43 -0700
Message-ID: <3592CAFD.1360AA3A@netscape.com>
Date: Thu, 25 Jun 1998 18:11:09 -0400
From: Mike Shaver <shaver@netscape.com>
Organization: Mozilla Dot Weenies
X-Mailer: Mozilla 4.06 [en] (X11; I; Linux 2.0.34 i686)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: New 2.0.107 console scheme
References: <m0ypIvl-000aOnC@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alan Cox wrote:
> Almost and no. Its not fb_con thats relevant for the indy. fbcon is a directly
> accessible bitmapped display. The indy will need to use abscon directly  to
> issue newport commands

So, um, yeah.
I've been wading through the newport docs and the X server code and docs
and so forth for about 3 days now (good thing my boss is away!), and I'm
starting to think that I might almost understand what I have to do.

Things that are still unclear:
- do we use /dev/graphics, and make that work correctly (it doesn't
quite right now), or do we tweak the Newport HW from the X server
directly for things like board detection, etc.?
- where is the mouse driver coming from?
- why does it always take me so long to read these silly docs?
- why are there no good examples of writing a non-frame-buffered X
server?
- why haven't I yet bothered the people I work with at Netscape who
worked on the original SGI X server?
- why (and I've looked closely at this for 5 hours this week) does EFS
still do dumb things?

Thank you for listening.  I feel much better now.

Mike

-- 
452526.29 378522.30
