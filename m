Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2009 20:52:03 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:60824 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S21368294AbZCTUv4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2009 20:51:56 +0000
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Mar 2009 13:51:46 -0700
Received: from localhost.localdomain (unknown [10.8.0.60])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id 28AC6EE76A6;
	Fri, 20 Mar 2009 14:11:47 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH v2 0/6] Alchemy: Basic Au1300 and DBAu1300 support
Date:	Fri, 20 Mar 2009 15:51:40 -0500
Message-Id: <1237582306-10800-1-git-send-email-khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
X-OriginalArrivalTime: 20 Mar 2009 20:51:47.0696 (UTC) FILETIME=[AF8CA700:01C9A99D]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

This patch series introduces support for the RMI Alchemy Au1300 series of SOCs
and the DBAu1300 (or DB1300) development board.  With this set the basic CPU
and board are supported.  I have code for several of the peripherals, including
USB, MMC, IDE, and Ethernet and will submit those patches after these have been
accepted.

Though some of the new code added here could be useful for other boards (the
DB1200 in particular), I did my best to limit this patch set to additions only.
It should not disturb any other boards.  To verify this I built and tested the
updated directory for an on a DB1200 board.  A future patch set may include
some integration of this new code into the DB1200 configuration.

=Kevin

 arch/mips/Kconfig                                |    1 +
 arch/mips/Makefile                               |    6 +
 arch/mips/alchemy/Kconfig                        |   22 ++
 arch/mips/alchemy/common/Makefile                |    6 +-
 arch/mips/alchemy/common/au13xx_res.c            |   74 ++++++
 arch/mips/alchemy/common/dbdma.c                 |   46 ++++-
 arch/mips/alchemy/common/gpio_int.c              |  265 ++++++++++++++++++++++
 arch/mips/alchemy/common/platform.c              |   70 ++++++
 arch/mips/alchemy/common/time.c                  |    5 +
 arch/mips/alchemy/devboards/Makefile             |    6 +
 arch/mips/alchemy/devboards/cascade_irq.c        |  142 ++++++++++++
 arch/mips/alchemy/devboards/db1300/Makefile      |    6 +
 arch/mips/alchemy/devboards/db1300/board_setup.c |  124 ++++++++++
 arch/mips/alchemy/devboards/leds.c               |   58 +++++
 arch/mips/include/asm/cpu.h                      |   10 +-
 arch/mips/include/asm/mach-au1x00/au1000.h       |   50 ++++
 arch/mips/include/asm/mach-au1x00/au13xx.h       |  201 ++++++++++++++++
 arch/mips/include/asm/mach-au1x00/au1xxx.h       |    3 +
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |   33 +++
 arch/mips/include/asm/mach-au1x00/dev_boards.h   |   44 ++++
 arch/mips/include/asm/mach-au1x00/gpio_int.h     |  237 +++++++++++++++++++
 arch/mips/include/asm/mach-au1x00/irq.h          |   34 +++
 arch/mips/include/asm/mips-boards/db1300.h       |  121 ++++++++++
 arch/mips/kernel/cpu-probe.c                     |   20 ++
 arch/mips/mm/c-r4k.c                             |    1 +
 arch/mips/mm/tlbex.c                             |    1 +
 drivers/video/Kconfig                            |    2 +-
 27 files changed, 1582 insertions(+), 6 deletions(-)
