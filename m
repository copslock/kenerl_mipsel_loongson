Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id BAA416282 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Dec 1997 01:27:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA19896 for linux-list; Mon, 22 Dec 1997 01:18:16 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA19858 for <linux@engr.sgi.com>; Mon, 22 Dec 1997 01:17:50 -0800
Received: from netscape.com (h-205-217-237-47.netscape.com [205.217.237.47]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id BAA26828
	for <linux@engr.sgi.com>; Mon, 22 Dec 1997 01:17:49 -0800
	env-from (shaver@netscape.com)
Received: from dredd.mcom.com (dredd.mcom.com [205.217.237.54])
	by netscape.com (8.8.5/8.8.5) with ESMTP id BAA16117
	for <linux@engr.sgi.com>; Mon, 22 Dec 1997 01:17:07 -0800 (PST)
Received: from netscape.com ([205.217.243.3]) by dredd.mcom.com
          (Netscape Messaging Server 3.0)  with ESMTP id AAA23070
          for <linux@engr.sgi.com>; Mon, 22 Dec 1997 01:17:07 -0800
Message-ID: <349E2FCF.605C2665@netscape.com>
Date: Mon, 22 Dec 1997 01:15:59 -0800
From: Mike Shaver <shaver@netscape.com>
Organization: Package Reflectors
X-Mailer: Mozilla 4.02 [en] (X11; U; IRIX 6.2 IP22)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: flush_cache_all() hoses my Indy
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

OK, I've been tracking a bug that only seems to appear on the Indy I
have at home right now (belongs to the housemates).  After sgiseeq_init
allocates the ring buffers, it calls flush_cache_all().  On this system,
that zeroes out the ring buffer pointers (rx and tx -- likely the entire
dev->priv block and more) and then setup_tx_ring gets understandably
upset. =)

Anyway, I'm not enough of a MIPS guru to really say much more, but I'll
poke around tonight and see if I can stumble across anything useful.

Linux reports:
MIPS 4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE
CPU Revision 0460

hinv tells me:
1 200 MHZ IP22 Processor
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
CPU: MIPS R4400 Processor Chip Revision: 6.0
Instruction cache size: 16 Kbytes
Data cache size: 16 Kbytes

More than this I do not know, but I'll run any test that doesn't risk
permanent damage.

Mike
