Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA01406; Thu, 17 Apr 1997 15:23:42 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA03318 for linux-list; Thu, 17 Apr 1997 15:23:01 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA03306 for <linux@engr.sgi.com>; Thu, 17 Apr 1997 15:22:58 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id PAA01191 for <linux@engr.sgi.com>; Thu, 17 Apr 1997 15:22:52 -0700
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id XAA23226
	for <linux@engr.sgi.com>; Thu, 17 Apr 1997 23:19:59 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id AAA14860 for linux@engr.sgi.com; Fri, 18 Apr 1997 00:21:26 +0200
Message-Id: <199704172221.AAA14860@kernel.panic.julia.de>
Subject: ECOFF booting
To: linux@cthulhu.engr.sgi.com
Date: Fri, 18 Apr 1997 00:21:26 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

due to problems with the current bootloader Milo for the little endian
machines when recompiling I finally took myself the time to fix the
ELF to ECOFF converter.  This should also solve the problems with
older ECOFF-only firmware in Indyies.  The code will be in Milo 0.28
to be released as soon as it has been tested on Magnums/Olivetties.

  Ralf

-- 
74 a3 53 cc 0b 19
