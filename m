Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA31648 for <linux-archive@neteng.engr.sgi.com>; Thu, 17 Dec 1998 14:25:33 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA38697
	for linux-list;
	Thu, 17 Dec 1998 14:24:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA39485
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 17 Dec 1998 14:24:13 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-47.netscape.com [205.217.237.47]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08953
	for <linux@cthulhu.engr.sgi.com>; Thu, 17 Dec 1998 14:24:12 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from tintin.mcom.com (tintin.mcom.com [205.217.233.42])
	by netscape.com (8.8.5/8.8.5) with ESMTP id OAA11536
	for <linux@cthulhu.engr.sgi.com>; Thu, 17 Dec 1998 14:24:09 -0800 (PST)
Received: from netscape.com ([205.217.243.67]) by
          tintin.mcom.com (Netscape Messaging Server 4.0) with ESMTP id
          F44RK800.DX0; Thu, 17 Dec 1998 14:24:08 -0800 
Message-ID: <367984B8.62A40F40@netscape.com>
Date: Thu, 17 Dec 1998 17:24:56 -0500
From: Mike Shaver <shaver@netscape.com>
Organization: Just Another Snake Cult
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.1.131 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Hartensveld <richard@infopact.nl>
CC: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: console on serial
References: <3678F801.C399874F@infopact.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Richard Hartensveld wrote:
> I'm trying to get linux installed on a challenge S, which has no video
> board, all goes pretty
> well until i get into userland and the kernel wants to open
> /dev/console, which i would
> like to be a terminal on the serial port, is this possible?

Yeah, that's how I boot my Indy when I need to capture early-on kernel
dumps.
Make sure that /dev/console is a symlink to /dev/ttyS0.

I assume the prom is set correctly, because you're getting this far.

Mike

-- 
24926.91 21925.54
