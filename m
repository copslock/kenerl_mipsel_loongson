Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA98310 for <linux-archive@neteng.engr.sgi.com>; Wed, 24 Feb 1999 02:12:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA11316
	for linux-list;
	Wed, 24 Feb 1999 02:12:09 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA47879
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 Feb 1999 02:12:07 -0800 (PST)
	mail_from (gkm@total.net)
Received: from bretweir.total.net (bretweir.total.net [205.236.175.106]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA04037
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 Feb 1999 02:12:06 -0800 (PST)
	mail_from (gkm@total.net)
From: gkm@total.net
Received: from total.net (local-182.montreal.mpact.net [204.19.168.182])
	by bretweir.total.net (8.9.1/8.8.5) with ESMTP id FAA26317
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 Feb 1999 05:11:50 -0500 (EST)
Message-Id: <199902241011.FAA26317@bretweir.total.net>
X-Mailer: exmh version 2.0.2
To: linux@cthulhu.engr.sgi.com
Subject: A few(bunch? :) of questions.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Feb 1999 05:12:04 -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I've managed to grab myself a Challenge-S and have been playing with it and 
Linux.

I've gotten hardhat installed by grabbing the latest kernel image from the 
test directory.
Everything is running nice, but now that it's alive, I have a few questions.

First, has the swap problem been worked out of the latest kernels? (be hard to 
put the beast to work with no swap)

My console doesn't work, the log shows lots of getty HANGUP signals and then 
init stopping the process.

I'd like to compile a kernel that's configured for what I'm running(no hanging 
around waiting for Bootp to time out and such) Where can I get the latest 
kernel source? (base 2.2.1 blows up impressivly when trying to compile :)

Related to the above:  How do I get support for the second ethernet and all 
the other SCSI adapters?

Is there anyway I can dump the Irix drive?  As it is now, the 1 Gig drive is 
used to hold vmlinux, that's it. Is milo something that works?

I've managed to get Vnc working on the unit, so I can so virtual X stuff, very 
cool and fun. (wasn't a bad compile, just a few things to adjust)

I think that covers it for now, the Challenge is a fun toy, and under 
unixbench comes out close to my P120 Laptop.
(I can post the results if anyone's interested)

Greg
