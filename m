Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2008 18:09:59 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:50317 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S28588304AbYGRRJu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2008 18:09:50 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m6IH8is0023206;
	Fri, 18 Jul 2008 10:09:20 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 18 Jul 2008 10:08:44 -0700
Received: from localhost.localdomain ([172.25.32.36]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 18 Jul 2008 10:08:44 -0700
From:	Jason Wessel <jason.wessel@windriver.com>
To:	linux-kernel@vger.kernel.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0/3] kgdb 2.6.27 mips
Date:	Fri, 18 Jul 2008 12:08:45 -0500
Message-Id: <1216400928-29097-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.5.5.1
X-OriginalArrivalTime: 18 Jul 2008 17:08:44.0598 (UTC) FILETIME=[EF653560:01C8E8F8]
Return-Path: <jason.wessel@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason.wessel@windriver.com
Precedence: bulk
X-list: linux-mips

This is a pretty significant change to kgdb mips in that it removes
the per board kgdb support to replace it with general kgdb
architecture support using the kernel's kgdb core architecture.

In the new model kgdb has no impact to the kernel's run time exceptions
or performance so long as no kgdb I/O driver is configured.

For boards that need specific uart drivers for kgdb, it should not be
too hard to add in kgdboc support as was done for the 8250 uart which
is supported by many of the mips specific boards already.

Jason Wessel (3):
      kgdb, mips: Remove existing kgdb implementation
      kgdb, mips: add arch support for the kernel's kgdb core
      kgdb, mips: pad pt_regs on MIPS64 for function arguments in an exception

 arch/mips/Kconfig                              |    7 +-
 arch/mips/Kconfig.debug                        |   22 -
 arch/mips/au1000/Kconfig                       |    1 -
 arch/mips/au1000/common/Makefile               |    1 -
 arch/mips/au1000/common/dbg_io.c               |  109 ---
 arch/mips/basler/excite/Makefile               |    1 -
 arch/mips/basler/excite/excite_dbg_io.c        |  121 ---
 arch/mips/basler/excite/excite_irq.c           |    7 -
 arch/mips/basler/excite/excite_setup.c         |    4 +-
 arch/mips/configs/db1000_defconfig             |    1 -
 arch/mips/configs/db1100_defconfig             |    1 -
 arch/mips/configs/db1200_defconfig             |    1 -
 arch/mips/configs/db1500_defconfig             |    1 -
 arch/mips/configs/db1550_defconfig             |    1 -
 arch/mips/configs/excite_defconfig             |    1 -
 arch/mips/configs/ip27_defconfig               |    1 -
 arch/mips/configs/msp71xx_defconfig            |    2 -
 arch/mips/configs/mtx1_defconfig               |    1 -
 arch/mips/configs/pb1100_defconfig             |    1 -
 arch/mips/configs/pb1500_defconfig             |    1 -
 arch/mips/configs/pb1550_defconfig             |    1 -
 arch/mips/configs/pnx8550-jbs_defconfig        |    4 +-
 arch/mips/configs/pnx8550-stb810_defconfig     |    4 +-
 arch/mips/configs/rbtx49xx_defconfig           |    1 -
 arch/mips/configs/sb1250-swarm_defconfig       |    1 -
 arch/mips/configs/yosemite_defconfig           |    2 -
 arch/mips/kernel/Makefile                      |    2 +-
 arch/mips/kernel/gdb-stub.c                    | 1155 ------------------------
 arch/mips/kernel/irq.c                         |   30 +-
 arch/mips/kernel/kgdb.c                        |  295 ++++++
 arch/mips/kernel/{gdb-low.S => kgdb_handler.S} |  161 ++---
 arch/mips/kernel/traps.c                       |    6 +
 arch/mips/mti-malta/Makefile                   |    1 -
 arch/mips/mti-malta/malta-init.c               |   54 --
 arch/mips/mti-malta/malta-kgdb.c               |  133 ---
 arch/mips/mti-malta/malta-setup.c              |    4 -
 arch/mips/nxp/pnx8550/common/Makefile          |    1 -
 arch/mips/nxp/pnx8550/common/gdb_hook.c        |  109 ---
 arch/mips/nxp/pnx8550/common/setup.c           |   12 -
 arch/mips/pmc-sierra/msp71xx/msp_serial.c      |   73 --
 arch/mips/pmc-sierra/yosemite/Makefile         |    1 -
 arch/mips/pmc-sierra/yosemite/dbg_io.c         |  180 ----
 arch/mips/pmc-sierra/yosemite/irq.c            |    9 -
 arch/mips/sgi-ip22/ip22-setup.c                |   24 -
 arch/mips/sgi-ip27/Makefile                    |    1 -
 arch/mips/sgi-ip27/ip27-dbgio.c                |   60 --
 arch/mips/sibyte/bcm1480/irq.c                 |   80 --
 arch/mips/sibyte/cfe/setup.c                   |   14 -
 arch/mips/sibyte/sb1250/irq.c                  |   60 --
 arch/mips/sibyte/swarm/Makefile                |    1 -
 arch/mips/sibyte/swarm/dbg_io.c                |   76 --
 arch/mips/txx9/Kconfig                         |    2 -
 arch/mips/txx9/generic/Makefile                |    1 -
 arch/mips/txx9/generic/dbgio.c                 |   48 -
 arch/mips/txx9/jmr3927/Makefile                |    1 -
 arch/mips/txx9/jmr3927/kgdb_io.c               |  105 ---
 include/asm-mips/asmmacro-32.h                 |   43 +
 include/asm-mips/asmmacro-64.h                 |   99 ++
 include/asm-mips/kgdb.h                        |   54 ++
 include/asm-mips/ptrace.h                      |    2 +-
 60 files changed, 569 insertions(+), 2626 deletions(-)
 delete mode 100644 arch/mips/au1000/common/dbg_io.c
 delete mode 100644 arch/mips/basler/excite/excite_dbg_io.c
 delete mode 100644 arch/mips/kernel/gdb-stub.c
 create mode 100644 arch/mips/kernel/kgdb.c
 rename arch/mips/kernel/{gdb-low.S => kgdb_handler.S} (68%)
 delete mode 100644 arch/mips/mti-malta/malta-kgdb.c
 delete mode 100644 arch/mips/nxp/pnx8550/common/gdb_hook.c
 delete mode 100644 arch/mips/pmc-sierra/yosemite/dbg_io.c
 delete mode 100644 arch/mips/sgi-ip27/ip27-dbgio.c
 delete mode 100644 arch/mips/sibyte/swarm/dbg_io.c
 delete mode 100644 arch/mips/txx9/generic/dbgio.c
 delete mode 100644 arch/mips/txx9/jmr3927/kgdb_io.c
 create mode 100644 include/asm-mips/kgdb.h
