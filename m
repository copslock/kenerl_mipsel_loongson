Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA13409 for <linux-archive@neteng.engr.sgi.com>; Thu, 25 Jun 1998 16:42:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA33465
	for linux-list;
	Thu, 25 Jun 1998 16:42:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA87963
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 Jun 1998 16:42:45 -0700 (PDT)
	mail_from (miguel@athena.nuclecu.unam.mx)
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id QAA15962
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 Jun 1998 16:42:37 -0700 (PDT)
	mail_from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.7/8.8.7) id SAA27827;
	Thu, 25 Jun 1998 18:42:18 -0500
Date: Thu, 25 Jun 1998 18:42:18 -0500
Message-Id: <199806252342.SAA27827@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: shaver@netscape.com
CC: alan@lxorguk.ukuu.org.uk, linux@cthulhu.engr.sgi.com
In-reply-to: <3592CAFD.1360AA3A@netscape.com> (message from Mike Shaver on
	Thu, 25 Jun 1998 18:11:09 -0400)
Subject: Re: New 2.0.107 console scheme
X-Windows: More than enough rope.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> - do we use /dev/graphics, and make that work correctly (it doesn't
> quite right now), or do we tweak the Newport HW from the X server
> directly for things like board detection, etc.?

Fix /dev/graphics if it is broken.

Miguel
