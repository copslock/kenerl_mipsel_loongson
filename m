Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA07899 for <linux-archive@neteng.engr.sgi.com>; Fri, 18 Dec 1998 04:38:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA58698
	for linux-list;
	Fri, 18 Dec 1998 04:37:25 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA58443
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 18 Dec 1998 04:37:23 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from smtp1.casema.net (sun4000.casema.net [195.96.96.97]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA02788
	for <linux@cthulhu.engr.sgi.com>; Fri, 18 Dec 1998 04:37:22 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from infopact.nl (9dyn35.breda.casema.net [195.96.116.35]) by smtp1.casema.net (8.9.1/CASEMA) with ESMTP id NAA00878; Fri, 18 Dec 1998 13:36:41 +0100 (MET)
Posted-Date: Fri, 18 Dec 1998 13:36:41 +0100 (MET)
Message-ID: <367A4D40.81E7F946@infopact.nl>
Date: Fri, 18 Dec 1998 04:40:33 -0800
From: Richard Hartensveld <richard@infopact.nl>
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.5 IP22)
MIME-Version: 1.0
To: Mike Shaver <shaver@netscape.com>
CC: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: console on serial
References: <3678F801.C399874F@infopact.nl> <367984B8.62A40F40@netscape.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver wrote:

> Richard Hartensveld wrote:
> > I'm trying to get linux installed on a challenge S, which has no video
> > board, all goes pretty
> > well until i get into userland and the kernel wants to open
> > /dev/console, which i would
> > like to be a terminal on the serial port, is this possible?
>
> Yeah, that's how I boot my Indy when I need to capture early-on kernel
> dumps.
> Make sure that /dev/console is a symlink to /dev/ttyS0.

I made a ttyS0 on the nfs-root filesystem and linked /dev/console to it, i
no longer get the
message 'can't open console' but no message at all :). i made the ttyS0
device using mknod ttyS0 c 4 64.

I seem to be forgetting something, anyone who can fill me in here ?

Richard
