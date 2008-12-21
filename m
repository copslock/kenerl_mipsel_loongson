Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:26:31 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:2440 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S22774217AbYLUI03 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:29 +0000
Received: (qmail 3944 invoked from network); 21 Dec 2008 09:24:57 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:24:57 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 00/14] Alchemy updates v6
Date:	Sun, 21 Dec 2008 09:26:13 +0100
Message-Id: <cover.1229846410.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

This is a new and updated patchset which aims to improve alchemy support.
All patches have been run-tested on Au1200(db1200 and a custom au1250 platform)
 and compile-tested on all other in-kernel alchemy boards.

They can be roughly grouped into 3 sections:
#1-#3:  devboard code move and consolidation,
#4-#6:  alchemy irq updates,
#7-#14: cleanups, timer and pm updates (the previous 5 incarnations of
        this patchset).

Patch overview:
#1-#3:  move alchemy devboards to a common subdirectoy, share some code,
        and move the parts which amend the commandline out of common/.

#4:	update core alchemy irq code (see patch for details).
#5:     update the pb1200 cpld irq handler,
#6:	print the handler name in /proc/interrupts.

#7:	remove unused function,
#8:	remove cpu_table (it's more or less unused and unmaintained),
#9:	make r4k csrc/cevt available as fallback solution
#10:	alchemy csrc/cevt support
#11:	cleanup,
#12:	core PM updates and compile fixes for Au1200/Au1550
#13:	DBDMA PM support (again, for Au1200/Au1550)
#14:	new userspace PM interface for alchemy devboards.

As always, comments and testers welcome!

Thanks and regards,
	Manuel Lauss

---

Changes V5->V6:
- added patches #1-#6 (code move and irq updates)
- alchemy cevt now works with hrtimers
- xxs1500 and mtx-1 are now without suspend/resume support.  If anyone
  is inconvenienced by this, please speak up.

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



Manuel Lauss (14):
  Alchemy: move development board code to common subdirectory
  Alchemy: devboards: consolidate files
  Alchemy: move commandline mangling out of common code
  Alchemy: update core interrupt code.
  Alchemy: pb1200: update CPLD cascade irq handler.
  MIPS: print irq handler description
  Alchemy: remove get/set_au1x00_lcd_clock().
  Alchemy: remove cpu_table.
  MIPS: make cp0 counter clocksource/event usable as fallback.
  Alchemy: RTC counter clocksource / clockevent support.
  Alchemy: move calc_clock function.
  Alchemy: Fix up PM code on Au1550/Au1200
  Alchemy: dbdma suspend/resume support.
  Alchemy: new userspace suspend interface for development boards.

 arch/mips/Kconfig                                |    8 +
 arch/mips/Makefile                               |   24 +-
 arch/mips/alchemy/Kconfig                        |    5 +-
 arch/mips/alchemy/common/Makefile                |    4 +-
 arch/mips/alchemy/common/au1xxx_irqmap.c         |  205 ------
 arch/mips/alchemy/common/clocks.c                |   65 ++-
 arch/mips/alchemy/common/cputable.c              |   52 --
 arch/mips/alchemy/common/dbdma.c                 |   65 ++
 arch/mips/alchemy/common/irq.c                   |  745 +++++++++++-----------
 arch/mips/alchemy/common/power.c                 |  406 +++----------
 arch/mips/alchemy/common/reset.c                 |    2 -
 arch/mips/alchemy/common/setup.c                 |   71 +--
 arch/mips/alchemy/common/sleeper.S               |  118 ++--
 arch/mips/alchemy/common/time.c                  |  311 +++------
 arch/mips/alchemy/db1x00/Makefile                |    8 -
 arch/mips/alchemy/db1x00/board_setup.c           |  108 ----
 arch/mips/alchemy/db1x00/init.c                  |   62 --
 arch/mips/alchemy/db1x00/irqmap.c                |   86 ---
 arch/mips/alchemy/devboards/Makefile             |   18 +
 arch/mips/alchemy/devboards/db1x00/Makefile      |    8 +
 arch/mips/alchemy/devboards/db1x00/board_setup.c |  145 +++++
 arch/mips/alchemy/devboards/db1x00/irqmap.c      |   90 +++
 arch/mips/alchemy/devboards/pb1000/Makefile      |    8 +
 arch/mips/alchemy/devboards/pb1000/board_setup.c |  191 ++++++
 arch/mips/alchemy/devboards/pb1100/Makefile      |    8 +
 arch/mips/alchemy/devboards/pb1100/board_setup.c |  156 +++++
 arch/mips/alchemy/devboards/pb1200/Makefile      |    7 +
 arch/mips/alchemy/devboards/pb1200/board_setup.c |  164 +++++
 arch/mips/alchemy/devboards/pb1200/irqmap.c      |  134 ++++
 arch/mips/alchemy/devboards/pb1200/platform.c    |  166 +++++
 arch/mips/alchemy/devboards/pb1500/Makefile      |    8 +
 arch/mips/alchemy/devboards/pb1500/board_setup.c |  163 +++++
 arch/mips/alchemy/devboards/pb1550/Makefile      |    8 +
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   92 +++
 arch/mips/alchemy/devboards/pm.c                 |  229 +++++++
 arch/mips/alchemy/devboards/prom.c               |   62 ++
 arch/mips/alchemy/mtx-1/board_setup.c            |   12 +
 arch/mips/alchemy/mtx-1/irqmap.c                 |   18 +-
 arch/mips/alchemy/pb1000/Makefile                |    8 -
 arch/mips/alchemy/pb1000/board_setup.c           |  165 -----
 arch/mips/alchemy/pb1000/init.c                  |   57 --
 arch/mips/alchemy/pb1000/irqmap.c                |   38 --
 arch/mips/alchemy/pb1100/Makefile                |    8 -
 arch/mips/alchemy/pb1100/board_setup.c           |  109 ----
 arch/mips/alchemy/pb1100/init.c                  |   60 --
 arch/mips/alchemy/pb1100/irqmap.c                |   40 --
 arch/mips/alchemy/pb1200/Makefile                |    8 -
 arch/mips/alchemy/pb1200/board_setup.c           |  162 -----
 arch/mips/alchemy/pb1200/init.c                  |   58 --
 arch/mips/alchemy/pb1200/irqmap.c                |  160 -----
 arch/mips/alchemy/pb1200/platform.c              |  166 -----
 arch/mips/alchemy/pb1500/Makefile                |    8 -
 arch/mips/alchemy/pb1500/board_setup.c           |  119 ----
 arch/mips/alchemy/pb1500/init.c                  |   58 --
 arch/mips/alchemy/pb1500/irqmap.c                |   46 --
 arch/mips/alchemy/pb1550/Makefile                |    8 -
 arch/mips/alchemy/pb1550/board_setup.c           |   58 --
 arch/mips/alchemy/pb1550/init.c                  |   58 --
 arch/mips/alchemy/pb1550/irqmap.c                |   43 --
 arch/mips/alchemy/xxs1500/board_setup.c          |   12 +
 arch/mips/alchemy/xxs1500/irqmap.c               |   31 +-
 arch/mips/include/asm/mach-au1x00/au1000.h       |   89 ++-
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |    5 +
 arch/mips/include/asm/time.h                     |   24 +-
 arch/mips/kernel/Makefile                        |    4 +-
 arch/mips/kernel/cevt-r4k.c                      |    2 +-
 arch/mips/kernel/cpu-probe.c                     |    6 +-
 arch/mips/kernel/csrc-r4k.c                      |    2 +-
 arch/mips/kernel/irq.c                           |    1 +
 69 files changed, 2571 insertions(+), 3074 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/au1xxx_irqmap.c
 delete mode 100644 arch/mips/alchemy/common/cputable.c
 delete mode 100644 arch/mips/alchemy/db1x00/Makefile
 delete mode 100644 arch/mips/alchemy/db1x00/board_setup.c
 delete mode 100644 arch/mips/alchemy/db1x00/init.c
 delete mode 100644 arch/mips/alchemy/db1x00/irqmap.c
 create mode 100644 arch/mips/alchemy/devboards/Makefile
 create mode 100644 arch/mips/alchemy/devboards/db1x00/Makefile
 create mode 100644 arch/mips/alchemy/devboards/db1x00/board_setup.c
 create mode 100644 arch/mips/alchemy/devboards/db1x00/irqmap.c
 create mode 100644 arch/mips/alchemy/devboards/pb1000/Makefile
 create mode 100644 arch/mips/alchemy/devboards/pb1000/board_setup.c
 create mode 100644 arch/mips/alchemy/devboards/pb1100/Makefile
 create mode 100644 arch/mips/alchemy/devboards/pb1100/board_setup.c
 create mode 100644 arch/mips/alchemy/devboards/pb1200/Makefile
 create mode 100644 arch/mips/alchemy/devboards/pb1200/board_setup.c
 create mode 100644 arch/mips/alchemy/devboards/pb1200/irqmap.c
 create mode 100644 arch/mips/alchemy/devboards/pb1200/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1500/Makefile
 create mode 100644 arch/mips/alchemy/devboards/pb1500/board_setup.c
 create mode 100644 arch/mips/alchemy/devboards/pb1550/Makefile
 create mode 100644 arch/mips/alchemy/devboards/pb1550/board_setup.c
 create mode 100644 arch/mips/alchemy/devboards/pm.c
 create mode 100644 arch/mips/alchemy/devboards/prom.c
 delete mode 100644 arch/mips/alchemy/pb1000/Makefile
 delete mode 100644 arch/mips/alchemy/pb1000/board_setup.c
 delete mode 100644 arch/mips/alchemy/pb1000/init.c
 delete mode 100644 arch/mips/alchemy/pb1000/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1100/Makefile
 delete mode 100644 arch/mips/alchemy/pb1100/board_setup.c
 delete mode 100644 arch/mips/alchemy/pb1100/init.c
 delete mode 100644 arch/mips/alchemy/pb1100/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1200/Makefile
 delete mode 100644 arch/mips/alchemy/pb1200/board_setup.c
 delete mode 100644 arch/mips/alchemy/pb1200/init.c
 delete mode 100644 arch/mips/alchemy/pb1200/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1200/platform.c
 delete mode 100644 arch/mips/alchemy/pb1500/Makefile
 delete mode 100644 arch/mips/alchemy/pb1500/board_setup.c
 delete mode 100644 arch/mips/alchemy/pb1500/init.c
 delete mode 100644 arch/mips/alchemy/pb1500/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1550/Makefile
 delete mode 100644 arch/mips/alchemy/pb1550/board_setup.c
 delete mode 100644 arch/mips/alchemy/pb1550/init.c
 delete mode 100644 arch/mips/alchemy/pb1550/irqmap.c
