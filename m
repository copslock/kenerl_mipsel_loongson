Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA25871 for <linux-archive@neteng.engr.sgi.com>; Thu, 28 Jan 1999 00:13:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA16765
	for linux-list;
	Thu, 28 Jan 1999 00:12:37 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA25392
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 28 Jan 1999 00:12:36 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA04088
	for <linux@cthulhu.engr.sgi.com>; Thu, 28 Jan 1999 00:12:35 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id DAA06121
	for <linux@cthulhu.engr.sgi.com>; Thu, 28 Jan 1999 03:14:21 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 28 Jan 1999 03:14:21 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Problems modularizing newport graphics.
In-Reply-To: <Pine.LNX.3.96.990128025217.25641P-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.LNX.3.96.990128031304.25641Q-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 28 Jan 1999, Alex deVries wrote:
> But when I try to insert the module:
> [root@black char]# /sbin/insmod  /lib/modules/2.1.131/misc/graphics.o 
> /lib/modules/2.1.131/misc/graphics.o: couldn't find the kernel version the
> module was compiled for
> 
> I know this kernel was built for this kernel.  Using -f doesn't help.

Oh, never mind.  I'm just being stupid and forgot #include
<linux/module.h> because of an editing mistake.

Just ignore me and go back to doing what you were doing.

- Alex
