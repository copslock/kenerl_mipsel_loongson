Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA69845 for <linux-archive@neteng.engr.sgi.com>; Mon, 17 Aug 1998 11:46:13 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA40844
	for linux-list;
	Mon, 17 Aug 1998 11:45:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA13063
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Aug 1998 11:45:13 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn (dialup90-1-22.swipnet.se [130.244.90.22]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA01643
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Aug 1998 11:45:09 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: (from grim@localhost)
	by calypso.saturn (8.9.1/8.9.1/Debian/GNU) id UAA29545
	for linux@cthulhu.engr.sgi.com; Mon, 17 Aug 1998 20:45:01 +0200
From: Ulf Carlsson <grim@zigzegv.ml.org>
Message-Id: <199808171845.UAA29545@calypso.saturn>
Subject: bus error IRQ
To: linux@cthulhu.engr.sgi.com
Date: Mon, 17 Aug 1998 20:45:00 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

Got this little message which crashed the machine:

Got a bus error IRQ, shouldn't happen yet
$0 : 00000000 1004fc01 88008048 00000000
$4 : 88008000 88008000 fffffc18 00000001
$8 : 88009fe0 3004fc01 8803d2f8 00000003
$12: 00000038 000003e2 88350a08 89f5be18
$16: 00000000 00000000 8800a16c 00000f00
$20: a8747310 9fc45da0 00000000 9fc45da0
$24: 00000001 2ab0c110
$28: 88008000 88009e90 9fc45f0c 88013650
epc   : 880262b8
Status: 1004fc03
Cause : 00004000
Spinning...

That's in 'schedule'

    88026298:   03c0e821        move    $sp,$s8
    8802629c:   8fbf0040        lw      $ra,64($sp)
    880262a0:   8fbe003c        lw      $s8,60($sp)
    880262a4:   8fb40038        lw      $s4,56($sp)
    880262a8:   8fb30034        lw      $s3,52($sp)
    880262ac:   8fb20030        lw      $s2,48($sp)
    880262b0:   8fb1002c        lw      $s1,44($sp)
    880262b4:   8fb00028        lw      $s0,40($sp)
    880262b8:   03e00008        jr      $ra
    880262bc:   27bd0048        addiu   $sp,$sp,72

00000000880262c0 <__wake_up>:
    880262c0:   27bdfff8        addiu   $sp,$sp,-8
    880262c4:   afbe0000        sw      $s8,0($sp)

Do you know anything about this Ralf? Maybe it's fixed in some version I don't
have yet?

- Ulf
