Received:  by oss.sgi.com id <S305157AbQAMUHf>;
	Thu, 13 Jan 2000 12:07:35 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:37754 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQAMUHQ>;
	Thu, 13 Jan 2000 12:07:16 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA03433; Thu, 13 Jan 2000 12:04:19 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA29049
	for linux-list;
	Thu, 13 Jan 2000 11:56:22 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA19896
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 13 Jan 2000 11:56:19 -0800 (PST)
	mail_from (clemej@rpi.edu)
Received: from mail.rpi.edu (mail.rpi.edu [128.113.100.7]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAB02763
	for <linux@cthulhu.engr.sgi.com>; Thu, 13 Jan 2000 11:55:58 -0800 (PST)
	mail_from (clemej@rpi.edu)
Received: from rcs-sun1.rpi.edu (clemej@rcs-sun1.rpi.edu [128.113.113.14])
	by mail.rpi.edu (8.9.3/8.9.3) with SMTP id OAA72342
	for <linux@cthulhu.engr.sgi.com>; Thu, 13 Jan 2000 14:55:57 -0500
Date:   Thu, 13 Jan 2000 14:55:55 -0500 (EST)
From:   John Michael Clemens <clemej@rpi.edu>
To:     linux@cthulhu.engr.sgi.com
Subject: XZ graphics specs...
Message-ID: <Pine.SOL.3.96.1000113144736.4279E-100000@rcs-sun1.rpi.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


I too have been working on getting my Indigo2 to boot... and now that I
seem to have mine working as well, I can move on to actually helping.  

Now that the EISA stuff is in the kernel, should it now be possible to
write video drivers (framebuffers, console drivers, X servers) for the
Indigo2's???.. Having said that, I have GR3-Elan (XZ) graphics on mine,
can someone tell me where I can find the specs to start hacking up at
least a framebuffer for this?  techpubs.sgi.com doesn't seem to have much
info... is this info even availabe to those outside for SGI?

Also, can someone warn me about what dangers (if any) there will be to my
*VERY NICE* Sony GDM17E21 if I start playing around with video timings and
suff?  The last thing I need is to kill my only really nice monitor that I
use for my PC's and my SGI...

Any info would be MUCH appreciated.
john.c

- --
/* John Clemens     http://www.rpi.edu/~clemej _/ "I Hate Quotes"       */
/* ICQ: 7175925     clemej@rpi.edu           _/    -- Samuel L. Clemens */ 
/* RPI Comp. Eng. 2000, Linux Parallel/Network/OS/Driver Specialist     */
