Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA93163 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 10:05:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA24123
	for linux-list;
	Thu, 16 Jul 1998 10:04:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA45982
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 10:04:16 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA08054
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 10:04:12 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id TAA10353
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 19:04:11 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id TAA16568
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 19:04:06 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id TAA15570
	for linux@cthulhu.engr.sgi.com; Thu, 16 Jul 1998 19:04:09 +0200 (MET DST)
Message-Id: <199807161704.TAA15570@aisa.fi.muni.cz>
Subject: Some register dumps
In-Reply-To: <199807161354.PAA09548@aisa.fi.muni.cz> from Honza Pazdziora at "Jul 16, 98 03:54:50 pm"
To: linux@cthulhu.engr.sgi.com
Date: Thu, 16 Jul 1998 19:04:09 +0200 (MET DST)
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


The first register dump I got when I tried to rpm -Uvh kernel-headers.
I however believe that it was not caused by the package but by the
overall activity on the system -- on rpm, one make, one lmbench.
I still believe that I do not deserve a register dump ;-) I'm rewriting
the numbers from paper, so there will be mistakes, I'm sure:

Scheduling in interrupt
page fault from irq handler: 0001
$0: 00000000 88140000 00000018 00000009
$4: 88146100 00000001 8899e000 88146100
$8: 00000720 88008000 00000001 00000000
$12: 00000008 000003e2 883749dc 80000000
$16: 89182000 89182000 00000000 89182000
$20: 00000001 0000000b 1fffffff bfb90000
$24: 00000002 8814793c
$28: 89182000 89182568 89182568 880262e4
epc: 880262c4
Status: 3000fc03
Cause 0000000c
Aiee, killing interrupt handler

This run across the scrren for some while, then it stopped. The
previous copies seemed still the same -- at least at a glance.

The second dump I got when compilling ssh, going some ftps and ssh.

Scheduling in interrupt
page fault from irq handler: 0001
$0: 00000000 88140000 00000018 00000009
$4: 88146100 00000001 88700000 88146100
$8: 00000720 88008000 00000001 00000000
$12: 00000008 000003e2 883749dc 80000000
$16: 88ebe000 88ebe000 00000000 88ebe000
$20: 00000001 0000000b 1fffffff bfb90000
$24: 00000000 00000000
$28: 88ebe000 88ebe4e0 88ebe4e0 880s62c4
epc: 880262c4
Status: 3000fc03
Cause 0000000c
Aiee, killing interrupt handler

after which one line

kmem_free: Bad obj addr (objp = 88ebe430, name=signal_queue)

and then another 30 or so lines of

kmem_free: Bad obj addr (objp = 00000007, name=signal_queue)

This is 2.1.100 from HH 5.1 PR distribution, R4600PC, 32 MB.

The register lsitings wouldn't bother me if they did not crash my
machine at the same time ;-)

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
