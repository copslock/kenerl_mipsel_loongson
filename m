Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA42389 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Feb 1999 18:09:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA33627
	for linux-list;
	Mon, 8 Feb 1999 18:08:13 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA46064
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 8 Feb 1999 18:08:11 -0800 (PST)
	mail_from (miguel@metropolis.nuclecu.unam.mx)
Received: from metropolis.nuclecu.unam.mx (metropolis.nuclecu.unam.mx [132.248.29.92]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA02779
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Feb 1999 18:08:10 -0800 (PST)
	mail_from (miguel@metropolis.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by metropolis.nuclecu.unam.mx (8.8.7/8.8.7) id UAA13047;
	Mon, 8 Feb 1999 20:08:00 -0600
Date: Mon, 8 Feb 1999 20:08:00 -0600
Message-Id: <199902090208.UAA13047@metropolis.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: adevries@engsoc.carleton.ca
CC: linux@cthulhu.engr.sgi.com
In-reply-to: 
	<Pine.LNX.3.96.990208190624.11444G-100000@lager.engsoc.carleton.ca>
	(message from Alex deVries on Mon, 8 Feb 1999 19:53:26 -0500 (EST))
Subject: Re: newport stuff.
X-Quote: If at first you don't succeed, redefine success.
References:  <Pine.LNX.3.96.990208190624.11444G-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> Are there objctions to me stripping out functionality from the very
> excellent newport_cons.c and putting it into newport.c so I can use it
> from graphics. as well?

I do not see how much you can use from newport_cons.c into a
/dev/graphics driver.

Miguel.
