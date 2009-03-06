Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2009 16:20:18 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:35445 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S20808195AbZCFQUP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2009 16:20:15 +0000
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Mar 2009 08:20:09 -0800
Received: from localhost.localdomain (unknown [10.8.0.23])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id BF26E6E1D04;
	Fri,  6 Mar 2009 09:42:10 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Alchemy: Support for RMI Alchemy Au1300 and DBAu1300
Date:	Fri,  6 Mar 2009 10:19:59 -0600
Message-Id: <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
X-OriginalArrivalTime: 06 Mar 2009 16:20:09.0278 (UTC) FILETIME=[6B26EDE0:01C99E77]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips


This patch series introduces support for the RMI Alchemy Au1300 series of SOCs
and the DBAu1300 (or DB1300) development board.  With this set the basic CPU
and board are supported, as well as a few of the system peripherals.  USB, LCD,
UART, MMC/SD and ethernet drivers are included.  Other drivers are currently in
development and will be released in a later patch set.  All included code has
been tested and verified working on a DB1300 board.

Though some of the new code added here could be useful for other boards (the
DB1200 in particular), I did my best to limit this patch set to additions only.
It should not disturb any other boards.  To verify this I built and tested the
updated directory for an on a DB1200 board.  A future patch set may include
some integration of this new code into the DB1200 configuration.

 arch/mips/Kconfig                                |    1 +
 arch/mips/Makefile                               |    6 +
 arch/mips/alchemy/Kconfig                        |   22 +
 arch/mips/alchemy/common/Makefile                |    4 +-
 arch/mips/alchemy/common/au13xx_res.c            |  104 +
 arch/mips/alchemy/common/dbdma.c                 |   46 +-
 arch/mips/alchemy/common/gpio_int.c              |  268 +
 arch/mips/alchemy/common/irq.c                   |    3 +
 arch/mips/alchemy/common/platform.c              |   76 +-
 arch/mips/alchemy/common/time.c                  |   16 +
 arch/mips/alchemy/devboards/Makefile             |    6 +
 arch/mips/alchemy/devboards/cascade_irq.c        |  142 +
 arch/mips/alchemy/devboards/db1300/Makefile      |    6 +
 arch/mips/alchemy/devboards/db1300/board_setup.c |  123 +
 arch/mips/alchemy/devboards/db1300/mmc.c         |  154 +
 arch/mips/alchemy/devboards/leds.c               |   58 +
 arch/mips/configs/db1300_defconfig               | 1216 ++++
 arch/mips/include/asm/cpu.h                      |   10 +-
 arch/mips/include/asm/mach-au1x00/au1000.h       |   49 +
 arch/mips/include/asm/mach-au1x00/au13xx.h       |  207 +
 arch/mips/include/asm/mach-au1x00/au1xxx.h       |    3 +
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |   33 +
 arch/mips/include/asm/mach-au1x00/dev_boards.h   |   44 +
 arch/mips/include/asm/mach-au1x00/gpio_int.h     |  239 +
 arch/mips/include/asm/mach-au1x00/irq.h          |   34 +
 arch/mips/include/asm/mips-boards/db1300.h       |  120 +
 arch/mips/kernel/cpu-probe.c                     |   20 +
 arch/mips/mm/c-r4k.c                             |    1 +
 arch/mips/mm/tlbex.c                             |    1 +
 drivers/mmc/host/Kconfig                         |    2 +-
 drivers/mmc/host/au1xmmc.c                       |   18 +-
 drivers/net/Kconfig                              |    6 +
 drivers/net/Makefile                             |    3 +
 drivers/net/smsc9210/Makefile                    |    9 +
 drivers/net/smsc9210/ioctl_118.h                 |  298 +
 drivers/net/smsc9210/platform_alchemy.c          |   88 +
 drivers/net/smsc9210/platform_alchemy.h          |  117 +
 drivers/net/smsc9210/smsc9210.h                  |   23 +
 drivers/net/smsc9210/smsc9210_main.c             | 7189 ++++++++++++++++++++++
 drivers/usb/Kconfig                              |    1 +
 drivers/usb/host/ehci-au13xx.c                   |  213 +
 drivers/usb/host/ehci-hcd.c                      |    5 +
 drivers/video/Kconfig                            |    2 +-
 43 files changed, 10969 insertions(+), 17 deletions(-)
