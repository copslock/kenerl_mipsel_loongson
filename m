Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id QAA02146; Tue, 15 Jul 1997 16:35:27 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA03476 for linux-list; Tue, 15 Jul 1997 16:35:06 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA03445 for <linux@engr.sgi.com>; Tue, 15 Jul 1997 16:35:02 -0700
Received: from alpha.uni-koblenz.de (alpha.uni-koblenz.de [141.26.8.10]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA29597
	for <linux@engr.sgi.com>; Tue, 15 Jul 1997 16:34:56 -0700
	env-from (ralf@alpha.uni-koblenz.de)
Received: (from ralf@localhost) by alpha.uni-koblenz.de (8.8.3/8.8.3) id OAA24586; Tue, 15 Jul 1997 14:02:57 +0200
From: Ralf Baechle <ralf@alpha.uni-koblenz.de>
Message-Id: <199707151202.OAA24586@alpha.uni-koblenz.de>
Subject: Binutils 2.8.1.0.15
Date: Tue, 15 Jul 1997 14:02:56 +0200 (MEST)
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Apparently-To: <linux@cthulhu.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

after having found a couple of bugs in binutils 2.7 during the last
time I decided it'd about time to go for 2.8 instead of putting more
time into 2.7.  Out of the frying pan into the fire ...

 - binutils 2.8.0.13 still need the special patches to gas/config/tc-mips.c
   to be applied.  Otherwise they will reject the %HI, %hi and %lo
   operators.
 - since some pre-2.8 version binutils do optimize the case of the -N.
   This helps to reduce the output filesize but somehow ld layouts
   the segments wrong which results in a unuseable kernel.  Removing
   -N from the LDFLAGS in arch/mips/Makefile is a workaround.
 - The %gp_rel() operator is not implemented in GAS.  This means that
   we cannot assemble PIC code with GAS that is produced by current
   snapshots.
 - GAS still doesn't deal with _huge_ loops.  The only program I know
   of which is affected is lmbench, but that alone is reason enough
   to fix it.

  Ralf
