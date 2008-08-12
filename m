Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 18:43:01 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:1734 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28592142AbYHLRmy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Aug 2008 18:42:54 +0100
Received: (qmail 9083 invoked from network); 12 Aug 2008 19:42:52 +0200
Received: from flagship.roarinelk.net (HELO localhost.localdomain) (192.168.0.197)
  by 192.168.0.1 with SMTP; 12 Aug 2008 19:42:52 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Kevin Hickey <khickey@rmicorp.com>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 00/10] Alchemy updates v5
Date:	Tue, 12 Aug 2008 19:42:41 +0200
Message-Id: <cover.1218561745.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.5.6.4
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

[Ralf: Please consider this series for 2.6.27 inclusion if it is still
 possible to sneak them in]

Hello,

Here's again a new set of patches to modernize Alchemy setup and PM code.
All patches have been compile-tested with db1100 and db1200 defconfigs,
and have been runnning on a few custom Au1250 boards for now more than
5 weeks.  I've suspended and resumed a few hundred times while stressing
the system (continuous SD + CF reads while playing some wave files and
compiling sources).

#1  removes unused functions
#2  removes the cpu_table and replaces it with simpler code (IMHO of course)
#3  enables use of cp0 counter as a fallback,
#4  clockevent/clocksource support using one of the 2 counters of the Au1xxx
    this also enables the use of the 'wait' instruction; depends on #3
#5  cleanup made possible with #4 
#6  don't unconditionally include the platform.c file.  Not all boards may
    want all the devices registered in there, and its existence makes adding
    platform data to certain drivers needlessly ugly.
#7  and #8 fix suspend/resume.
#9  adds DBDMA suspend/resume support.
#10 replaces sysctl suspend interface with something better (IMO).
    It's not perfect but a step in the right direction.  If the need for
    changes arises (it works fine for the demoboards) it can be done
    on top of this patch.

All patches depend on each other, have been run-tested on db1200 and
custom au1200 boards as well as compile-tested with a minimal config
for db1100.

Changes V4->V5:
- rediffed against 2.6.27-rc2+
- again minor refinements.

Changes V3->V4:
- rediffed against 2.6.27-rc1
- add patch #10.

Changes V2->V3:
- swap patches 1 and 2 
- minor refinements, no function changes.

Changes V1->V2:
- address Sergei's comments wrt. config[OD] handling
- change TOY clocksource to RTC clocksource
- add another patch (#5)


Manuel Lauss (10):
  Alchemy: remove get/set_au1x00_lcd_clock().
  Alchemy: remove cpu_table.
  MIPS: make cp0 counter clocksource/event usable as fallback.
  Alchemy: RTC counter clocksource / clockevent support.
  Alchemy: move calc_clock function.
  Alchemy: compile platform.c only when building for a demoboard.
  Alchemy: split core PM code from sysctl parts.
  Alchemy: Fix PM code for Au1200/Au1550.
  Alchemy: dbdma suspend/resume support.
  Alchemy: new demoboard userspace suspend interface.

 arch/mips/Kconfig                     |    8 +
 arch/mips/au1000/Kconfig              |    4 +-
 arch/mips/au1000/common/Makefile      |    4 +-
 arch/mips/au1000/common/clocks.c      |   65 ++++--
 arch/mips/au1000/common/cputable.c    |   52 ----
 arch/mips/au1000/common/dbdma.c       |   65 +++++
 arch/mips/au1000/common/irq.c         |   57 +----
 arch/mips/au1000/common/platform.c    |  258 ++++++++++++++++++++-
 arch/mips/au1000/common/power.c       |  421 +++++++--------------------------
 arch/mips/au1000/common/setup.c       |   39 +---
 arch/mips/au1000/common/sleeper.S     |  121 ++++++----
 arch/mips/au1000/common/time.c        |  305 ++++++++----------------
 arch/mips/au1000/db1x00/Makefile      |    1 +
 arch/mips/au1000/mtx-1/Makefile       |    2 +-
 arch/mips/au1000/pb1000/Makefile      |    1 +
 arch/mips/au1000/pb1100/Makefile      |    1 +
 arch/mips/au1000/pb1200/Makefile      |    2 +-
 arch/mips/au1000/pb1500/Makefile      |    1 +
 arch/mips/au1000/pb1550/Makefile      |    1 +
 arch/mips/au1000/xxs1500/Makefile     |    1 +
 arch/mips/kernel/Makefile             |    4 +-
 arch/mips/kernel/cevt-r4k.c           |    2 +-
 arch/mips/kernel/csrc-r4k.c           |    2 +-
 include/asm-mips/mach-au1x00/au1000.h |   64 ++++--
 include/asm-mips/time.h               |   24 ++-
 25 files changed, 718 insertions(+), 787 deletions(-)
 delete mode 100644 arch/mips/au1000/common/cputable.c
