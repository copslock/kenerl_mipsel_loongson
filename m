Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id MAA21748; Tue, 15 Jul 1997 12:42:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA09622 for linux-list; Tue, 15 Jul 1997 12:42:26 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA09508 for <linux@engr.sgi.com>; Tue, 15 Jul 1997 12:42:07 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA08603
	for <linux@engr.sgi.com>; Tue, 15 Jul 1997 12:42:03 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id VAA00342; Tue, 15 Jul 1997 21:35:40 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199707151935.VAA00342@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id VAA03345; Tue, 15 Jul 1997 21:35:54 +0200
Subject: Fun with binutils ...
Date: Tue, 15 Jul 1997 21:35:53 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

after having found a couple of bugs in binutils 2.7 during the last
time I decided it'd about time to go for 2.8 instead of putting more
time into 2.7.  Out of the frying pan into the fire ...

 - binutils 2.8.0.13 still need the special patches to gas/config/tc-mips.c
   to be applied.  Otherwise they will reject the %HI, %hi and %lo
   operators.  Good so far, we never needed as few patches.
 - since some pre-2.8 version binutils do optimize the case of the -N.
   This helps to reduce the output filesize but somehow ld layouts
   the segments wrong which results in a unuseable kernel.  Removing
   -N from the LDFLAGS in arch/mips/Makefile is a workaround.
 - The %gp_rel() operator is not implemented in GAS.  This means that
   we cannot assemble PIC code with GAS that is produced by current
   snapshots.
 - ld spits messages about _gp_disp changing type.  Dunno why yet.
 - GAS still doesn't deal with _huge_ loops.  The only program I know
   of which is affected is lmbench, but that alone is reason enough
   to fix it :-)

  Ralf
