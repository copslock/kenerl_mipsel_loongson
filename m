Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA73616 for <linux-archive@neteng.engr.sgi.com>; Mon, 31 Aug 1998 09:56:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA70650
	for linux-list;
	Mon, 31 Aug 1998 09:56:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA09062
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 31 Aug 1998 09:56:13 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from ballyhoo.ml.org ([194.236.80.80]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA13253
	for <linux@cthulhu.engr.sgi.com>; Mon, 31 Aug 1998 09:56:04 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn ([130.244.73.47]) by ballyhoo.ml.org
	 with smtp (ident grim using rfc1413) id m0zDXEw-000xgkC
	(Debian Smail-3.2.0.101 1997-Dec-17 #2); Mon, 31 Aug 1998 18:55:38 +0200 (CEST)
Date: Mon, 31 Aug 1998 18:56:10 +0200 (CEST)
From: Ulf Carlsson <grim@zigzegv.ml.org>
X-Sender: grim@calypso.saturn
To: linux@cthulhu.engr.sgi.com
Subject: cdrom
Message-ID: <Pine.LNX.3.96.980831184941.15439A-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,
Has someone managed to mount a CD yet?

Unable to handle kernel paging request at virtual address 00000000, epc ==
88021bcc, ra == 880f51c4 Oops: 0000

....

epc   : 88021bcc
Status: 3004fc02
Cause : 00000008
Segmentition fault


Then i get the prompt back.

The second time I try:

scsi: aborting command due to timeout : pid 665, scsi0, channel 0, id4,
lun 0 Test Unit Ready 00 00 00 00 00
scsi0: Aborting connected command 665 - stopping DMA sending wd33c93 ABORT
command - flushing fifo - asr=00, sr=16, 0 bytes un-transferred
(timeout=-1) - sending wd33c93 DISCONNECT command - asr=00, sr=16.page
fault from irq handler: 0000

...

epc   : 88021bcc
Status: 1004fc02
Cause : 00000008
Aiee killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing

Really lots of error messages.

Well, I was thinking if I could boot from the cd and install without
networking, doesn't work very well though.

- Ulf
