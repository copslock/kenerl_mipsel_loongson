Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id BAA12138 for <linux-archive@neteng.engr.sgi.com>; Fri, 30 Apr 1999 01:54:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA11455
	for linux-list;
	Fri, 30 Apr 1999 01:52:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA86269
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 30 Apr 1999 01:52:49 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from aw.ivm.net (mail.ivm.net [195.78.161.2] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA08802
	for <linux@cthulhu.engr.sgi.com>; Fri, 30 Apr 1999 04:52:48 -0400 (EDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port22.koeln.ivm.de [195.247.239.22])
	by aw.ivm.net (8.8.8/8.8.8) with ESMTP id KAA10718;
	Fri, 30 Apr 1999 10:52:38 +0200
X-To: linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.990430105522.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Fri, 30 Apr 1999 10:55:22 +0200 (MEST)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To: linux-mips@fnet.fr, SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: CP0_STATUS interrupt mask patch
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi Gang,

two weeks ago I asked for comments on a patch which is essential for Linux
on DECstations but may trigger undiscovered bugs on other machines.

Well, I haven't got any feedback :-(

On the other hand, nobody said "don't do this!" :-)

If nobody stops me I am going to commit the patch I posted two weeks ago
and see what happens B)
---
Regards,
Harald

P.S.: Yes, I *do* have my asbestos suit within reach.
